require 'facebook/messenger'
require 'httparty' # you should require this one
require 'json' # and that one
include Facebook::Messenger
# NOTE: ENV variables should be set directly in terminal for testing on localhost

# Subcribe bot to your page
Facebook::Messenger::Subscriptions.subscribe(access_token: ENV["ACCESS_TOKEN"])
FEELING_BLUE = 'https://www.youtube.com/watch?v=dYqlYyQqzgY'
KITTEN_URL = 'https://s-media-cache-ak0.pinimg.com/236x/71/94/21/719421e372a03c9dcb5eb9cf6098b421.jpg'
API_URL = 'https://maps.googleapis.com/maps/api/geocode/json?address='

Bot.on :message do |message|
  puts "Received '#{message.inspect}' from #{message.sender}" # debug purposes
  parsed_response = get_parsed_response(API_URL, message.text) # talk to Google API
  message.type # trick user into thinking we type something with our fingers, HA HA HA
  p parsed_response
  if !parsed_response || message.text == 'angry cat please'
      message.reply(
        attachment: {
          type: 'image', 
          payload: {
            url: KITTEN_URL
            }
          } 
        )
  else
    coord = extract_coordinates(parsed_response) # we have a separate method for that
    message.reply(text: "Latitude: #{coord['lat']}, Longitude: #{coord['lng']}")
  end
end

def get_parsed_response(url, query)
  # Use HTTParty gem to make a get request
  response = HTTParty.get(url + query)
  # Parse the resulting JSON so it's now a Ruby Hash
  parsed = JSON.parse(response.body)
  # Return nil if we got no results from the API.
  parsed['status'] != 'ZERO_RESULTS' ? parsed : nil
end

# Look inside the hash to find coordinates
def extract_coordinates(parsed)
  parsed['results'].first['geometry']['location']
end
