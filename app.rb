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
	@wetout = "#{year} year! #{month} is the month! #{day} is the day!"  
        Weatherparse.forecast(year,month,day)
        @pressure = Weatherparse.pressure
        @wetout = "#{@wetout} and here's some weather #{@pressure} is the pressure \n //BEGIN CODE"  
	erb :weather
end

class Weatherparse
   @@testman = "ham"
   def self.forecast(year,month,day)  
      Forecast::IO.configure do |configuration|
        configuration.api_key = '284bc96ec58d70d124724420603ff493'
      end 
      def self.pressure 
      @@pressure 
      end 
      forecast = Forecast::IO.forecast(29.9728,-90.0590, time: Time.new(2005,8,29).to_i)
      forecast.time = Time.new(year = 2013,month = 1,day = 2).to_i 
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
#add second method for second location 
   def self.dewpoint 
    @@weatheroutput  = "SincOsc #{@@testman} test #{@pressure}"    
      puts @@weatheroutput  

   end 
end   
