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
	@wetout = "#{year} year! #{month} is the month! #{day} is the day!"  
        Weatherparse.forecast(year,month,day,location)
        @pressure = Weatherparse.pressure
        @wetout = "#{@wetout} and here's some weather #{@pressure} is the pressure \n //BEGIN CODE"  
	erb :weather
end

class Weatherparse
   def self.forecast(year = 2013,month = 1,day = 2,location)  
      Forecast::IO.configure do |configuration|
        configuration.api_key = '284bc96ec58d70d124724420603ff493'
      end 
      def self.pressure 
      @@pressure 
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
      forecast = Forecast::IO.forecast(longitude,latitude, time: Time.new(year,month = 8 ,day = 1).to_i)
      forecast.time = Time.new(year = 2013,month = 1,day = 2).to_i
      #if location == "New York" 
     # forecast.longitude =  
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
