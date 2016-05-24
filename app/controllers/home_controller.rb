class HomeController < ApplicationController
  def index
    @states = %w(HI AK CA OR WA ID UT NV AZ NM CO WY MT ND SD NB KS OK TX LA AR MO IA MN WI IL IN MI OH KY TN MS AL GA FL SC NC VA WV DE MD PA NY NJ CT RI MA VT NH ME DC).sort!

    # response = HTTParty.get("http://api.wunderground.com/api/#{ENV['wunderground_api_key']}/geolookup/conditions/q/NC/Charlotte.json")

    if params[:city] != nil
      params[:city].gsub!(" ", "_")
    end

    if params[:state] != nil && params[:city] != nil
      response = HTTParty.get("http://api.wunderground.com/api/#{ENV['wunderground_api_key']}/geolookup/conditions/q/#{params[:state]}/#{params[:city]}.json")
    else
      response = HTTParty.get("http://api.wunderground.com/api/#{ENV['wunderground_api_key']}/geolookup/conditions/q/NC/Charlotte.json")
    end

    @location = response['location']['city']
    @temp_f = response['current_observation']['temp_f']
    @temp_f = response['current_observation']['temp_c']
    @weather_icon = response['current_observation']['icon_url']
    @weather_words = response['current_observation']['weather']
    @forecast_link = response['current_observation']['forecast_url']
    @feels_like = response['current_observation']['feelslike_f']
  end

  def test
  	response = HTTParty.get("http://api.wunderground.com/api/#{ENV['wunderground_api_key']}/geolookup/conditions/q/NC/Charlotte.json")
  	@location = response['location']['city']
  	@temp_f = response['current_observation']['temp_f']
  	@temp_f = response['current_observation']['temp_c']
  	@weather_icon = response['current_observation']['icon_url']
  	@weather_words = response['current_observation']['weather']
  	@forecast_link = response['current_observation']['forecast_url']
  	@feels_like = response['current_observation']['feelslike_f']
  end
end
