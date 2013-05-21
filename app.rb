require 'sinatra'
require 'forecast_io'
 
get '/' do
	@wetout = "default"
        year = 2013
        month = 1
        day = 1
	erb :weather
end
 
post '/' do
	year = params[:post][:year]
	month = params[:post][:month] 
	day = params[:post][:day] 
        location = params[:post][:location] 
	@wetout = "Welcome \n"  
        Weatherparse.forecast(year,month,day,location)
        @pressure = Weatherparse.pressure
	@temperature = Weatherparse.temperature 
	@precipIntensity = Weatherparse.precipIntensity 
	@dewpoint = Weatherparse.dewpoint 
	@humidity = Weatherparse.humidity 
	@pressure = Weatherparse.pressure 
	@visibility = Weatherparse.visibility 
        @wetout = "\n 
        //BEGIN CODE \n
	(  
        Server.default.options.memSize = 512*1024;
        s.boot; 
        "
        if @temperature <= 30 
        @wetout = "#{@wetout} \n 
        SynthDef(\030,
{| freq = 440, gate = 1, sustain = 1, amp= 0.25, pitch= 100 |
  var sig, t,y; 
  t = EnvGen.kr(Env.perc(0.01, 0.3)) * Klang.ar(`[ [pitch, pitch + 200, pitch + 400],[0.3, 0.3, 0.3],[pi,pi,pi]], 1, 0) ; 
  sig = BPF.ar(t,rand(1300) + 100) * amp;
  Out.ar(0, sig ! 2) 
}).add;

p = Pbind(
                \\instrument, \\030,
                \\pitch, Prand([200,210,300,100,330], inf), 
                \\dur, Prand([ 2,3,4,5,0.5,0.1,3], inf),
                \\amp, 0.5).play;" 
        end 
        if @temperature >= 30  
        @wetout = "#{@wetout} \n 
	{Saw.ar(Line.ar(rand(300) + 300 ,rand(200) + 200 ,0.25),1,1) * EnvGen.ar(Env.perc(0.01,0.3)) }.play;

SynthDef(\\6090,
{| freq = 440, gate = 1, sustain = 1, amp= 0.25, pitch= 100 |
  var sig, t,y; 
  t = EnvGen.kr(Env.perc(0.01, 0.3)) * Saw.ar(Line.ar(rand(300) + pitch ,rand(200) + 200 ,0.25),1,1) ; 
  y = BPF.ar(t,rand(1300) + 100);
  sig = GVerb.ar(y, 10, 5, 0.7, 0.8, 60, 0.1, 0.5, 0.4) + y * amp;
  Out.ar(0, sig ! 2) 
}).add;

p = Pbind(
                \\instrument, \\6090,
                \\pitch, Prand([200,210,300,100,330], inf), 
                \\dur, Prand([ 2,3,4,5,0.5,0.1,3], inf),
                \\amp, 0.3).play;"        
	end
	if @temperature >= 90 
	@wetout = "#{@wetout} \n
	{SinOsc.ar(LFNoise1.kr(4,60,80),1,0.25).distort * SinOsc.kr(20,1,100000) * EnvGen.ar(Env.perc(0.01,8))
}.play;

{SinOsc.ar(LFNoise1.kr(4,1000,2000),1,0.25).distort * SinOsc.kr(20,1,100000)}.play;"
	end  
	@wetout = "#{@wetout} \n 
	{
HPF.ar(LPF.ar(BPF.ar(WhiteNoise.ar(0.4), 50, 0.4), 500) * Saw.ar(LFNoise2.ar(0.25,7),1,1) * 3 -0.25, 500);

}.play;

{ LPF.ar(BPF.ar( WhiteNoise.ar(0.4), 50, 0.4), 500) * 10 }.play;"	 
	if @precipIntensity >= 2
        @wetout = "#{@wetout} \n 
	var x;
x = HPF.ar(PinkNoise.ar(0.5).distort * 2, 200) * 0.1;

GVerb.ar(x, 105, 5, 0.7, 0.8, 60, 0.1, 0.5, 0.4) + x;

}.play;"
	end 
	if @precipIntensity >= 3
	@wetout = "#{@wetout} \n 
	{var t;
 var y; 
t = EnvGen.kr(Env.perc(0.01, rand(5)+ 0.5)) * WhiteNoise.ar(0.5); 


y = BPF.ar(t,rand(1300) + 100);

GVerb.ar(y, 105, 5, 0.7, 0.8, 60, 0.1, 0.5, 0.4) + y;
}.play" 
	end
	if @precipIntensity > 1 
	@wetout = "#{@wetout} \n
	
SynthDef(\\thunder,
{| freq = 440, gate = 1, sustain = 1, amp= 0.25|
  var sig, t,y; 
  t = EnvGen.kr(Env.perc(0.01, rand(5)+ 0.5)) * WhiteNoise.ar(0.5); 
  y = BPF.ar(t,rand(1300) + 100);
  sig = GVerb.ar(y, 105, 5, 0.7, 0.8, 60, 0.1, 0.5, 0.4) + y * amp;
  Out.ar(0, sig ! 2) 
}).add;

p = Pbind(
                \\instrument, \\thunder,
                \\dur, Prand([ 2,3,4,10,24,0.5,0.1,34], inf),
                \\amp, 0.5).play;"
	end
	if @dewpoint >= 1
	@wetout= "#{@wetout} \n {(SinOsc.ar(LFNoise2.ar(#{@dewpoint} / 5 ,800,#{@dewpoint} / 100) + 800,1,#{@dewpoint} / 300))}.play"
	end	
	if @humidity >= 1
	@wetout= "#{@wetout} \n  {DelayN.ar(Decay.ar(Dust.ar(#{@humidity},0.5), 0.3, SinOsc.ar),3,0.5)}.play;"
	end 
        if @pressure >= 1 
        @wetout = "#{@wetout} \n {LPF.ar(SinOsc.ar(SinOsc.kr(#{@pressure} / 1000 ,1, 40 + LFNoise1.ar(1,1,3)) + 5,1,0.25),400) }.play" 
        end 
        if @visibility <= 10 
	@wetout = "#{@wetout} \n {Impulse.ar(LFNoise1.ar(10 - #{@visibility},3,8),1,1)}.play;  
	{Dust.ar(LFNoise1.ar(5,3,8),1)}.play;  
	"
	end 
        
        @wetout = "#{@wetout} \n )" 
	erb :weather
end

class Weatherparse
   def self.forecast(year = 2013,month = 8,day = 2,location)  
      Forecast::IO.configure do |configuration|
        configuration.api_key = '284bc96ec58d70d124724420603ff493'
      end 
      def self.pressure 
      @@pressure 
      end 
      def self.temperature 
      @@temperature 
      end 
      def self.precipIntensity 
      @@precipItensity 
      end 
      def self.dewpoint 
      @@dewpoint 
      end 
      def self.humidity 
      @@humidity 
      end 
      def self.pressure 
      @@pressure 
      end 
      def self.visibility 
      @@visibility 
      end
      puts location
      if location == "New York" 
      longitude = 40.7142
      latitude = -74.0064
      puts longitude 
      puts latitude 
      end
      if location == "New Orleans" 
      longitude = 29.9728
      latitude = -90.0590
      puts longitude 
      puts latitude
      end 
      if location == "Portland" 
      longitude = 45.5236
      latitude = -122.6750
      puts longitude 
      puts latitude 
      end 
      if location == "San Francisco" 
      longitude = 37.7750 
      latitude = - 122.4183
      puts longitude
      puts latitude 
      end 
      forecast = Forecast::IO.forecast(longitude,latitude, time: Time.new(year,month = 8,day ).to_i ) 
      @@pressure = forecast.currently.pressure  
      puts "#{@@pressure} is the pressure" 
      @@precipItensity = forecast.currently.precipIntensity 
      puts "#{@@precipItensity} is the precipitation intensity" 
      @@dewpoint = forecast.currently.dewPoint
      puts "#{@@dewpoint} is the dewpoint baby"                  
      @@summary = forecast.currently.summary 
      puts @@summary
      @@temperature = forecast.currently.temperature 
      puts"#{ @@temperature} is the temperature"  
      @@windspeed = forecast.currently.windSpeed 
      puts "#{@@windspeed} is the windspeed"    
      @@windbearing = forecast.currently.windBearing 
      puts "#{@@windbearing}  is the wind bearing" 
      @@cloudcover = forecast.currently.cloudCover
      puts "#{@@cloudcover} is the cloud cover" 
      @@humidity = forecast.currently.humidity 
      puts "#{@@humidity} is the humidity" 
      @@visibility = forecast.currently.visibility 
      puts "#{@@visibility} is the visibility" 
      @@ozone = forecast.currently.ozone 
      puts "#{@@ozone} is the ozone" 
      @wetout = "#{@wetout} and it was worth a try"  
   end     

end   
