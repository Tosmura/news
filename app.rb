require "sinatra"
require "sinatra/reloader"
require "httparty"
def view(template); erb template.to_sym; end

get "/" do
  ### Get the weather
  # Evanston, Kellogg Global Hub... replace with a different location if you want
  lat = 42.0574063
  long = -87.6722787

  units = "imperial" # or metric, whatever you like
  key = "14131a729c5aa02a6a3b991ece7a99cb" # replace this with your real OpenWeather API key

  # construct the URL to get the API data (https://openweathermap.org/api/one-call-api)
  url = "https://api.openweathermap.org/data/2.5/onecall?lat=#{lat}&lon=#{long}&units=#{units}&appid=#{key}"

  # make the call
  @forecast = HTTParty.get(url).parsed_response.to_hash

  ##https://api.openweathermap.org/data/2.5/onecall?lat=42.0574063&lon=-87.6722787&units=imperial&appid=14131a729c5aa02a6a3b991ece7a99cb

  ### Get the news
  url = "http://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=b91dca20726348e596576ebd6e84e826"
  @news = HTTParty.get(url).parsed_response.to_hash
  view "news"
end
