# require 'HTTParty'
# require 'json'
#    API_KEY = 'AIzaSyBRpQVIJ8t40cxz4zbXVklg8XwGyDntCDY'
#    ROOT_URL = 'https://www.googleapis.com/youtube/v3/search'
#   query = "steven"
#   url = 'https://www.googleapis.com/youtube/v3/search/?q=steven+universe&part=snippet&key=#AIzaSyBRpQVIJ8t40cxz4zbXVklg8XwGyDntCDY'
#   response = HTTParty.get(url)
#   puts response 
#   # Parse the resulting JSON so it's now a Ruby Hash
#   parsed = JSON.parse(response.body)
#   puts parsed 
#   puts url 

#   # https://www.youtube.com/results?search_query

require 'yourub'
DEVELOPER_KEY = 'AIzaSyCVhtKbqqUK6f56QCySSGZ4qvhOf9rWXDM'
# const ROOT_URL = 'https://www.googleapis.com/youtube/v3/search'
#

options = { developer_key: DEVELOPER_KEY,
             application_name: 'facebook bot',
             application_version: 0.1,
             log_level: 3 }

client = Yourub::Client.new(options)
client.search(query: 'steven universe') do |v|
  puts v["id"]
end

require 'facebook/messenger'
# require 'httparty' # you should require this one
# require 'json' # and that one
# require 'yourub'
include Facebook::Messenger
# NOTE: ENV variables should be set directly in terminal for testing on localhost

# Subcribe bot to your page
Facebook::Messenger::Subscriptions.subscribe(access_token: ENV["ACCESS_TOKEN"])

# require 'yourub'
DEVELOPER_KEY = 'AIzaSyCVhtKbqqUK6f56QCySSGZ4qvhOf9rWXDM'
# const ROOT_URL = 'https://www.googleapis.com/youtube/v3/search'
#

# options = { developer_key: DEVELOPER_KEY,
#              application_name: 'facebook bot',
#              application_version: 0.1,
#              log_level: 3 }

# client = Yourub::Client.new(options)

def yourub(query)
['dYqlYyQqzgY',
'YXs7Q6akMB8',
'ZEeZDU0ilC8',
'aVD5fmkLZcM',
'dHg50mdODFM']
end


# https://github.com/edap/yourub/blob/master/lib/yourub/client.rb
Bot.on :message do |message|
  
  # puts "Received '#{message.inspect}' from #{message.sender}" # debug purposes
  # array_of_videos = yourub(message.text) # talk to Google API
  # message.type # trick user into thinking we type something with our fingers, HA HA HA
  # # coord = extract_coordinates(parsed_response) # we have a separate method for that
  # choose_a_video = array_of_videos[rand(4)]
  # message.reply(attachment: {type: 'video', payload: {url: 'https://www.youtube.com/watch?v=' + choose_a_video}})
end



#!/usr/bin/ruby

require 'rubygems'
gem 'google-api-client',  '>0.7'

require 'google/api_client'
# require 'google-api-client'
require 'trollop'

# Set DEVELOPER_KEY to the API key value from the APIs & auth > Credentials
# tab of
# {{ Google Cloud Console }} <{{ https://cloud.google.com/console }}>
# Please ensure that you have enabled the YouTube Data API for your project.
DEVELOPER_KEY = 'REPLACE_ME'
YOUTUBE_API_SERVICE_NAME = 'youtube'
YOUTUBE_API_VERSION = 'v3'

def get_service
  client = Google::APIClient.new(
    :key => DEVELOPER_KEY,
    :authorization => nil,
    :application_name => $PROGRAM_NAME,
    :application_version => '1.0.0'
  )
  youtube = client.discovered_api(YOUTUBE_API_SERVICE_NAME, YOUTUBE_API_VERSION)

  return client, youtube
end

def main
  opts = Trollop::options do
    opt :q, 'Search term', :type => String, :default => 'Google'
    opt :max_results, 'Max results', :type => :int, :default => 25
  end

  client, youtube = get_service

  begin
    # Call the search.list method to retrieve results matching the specified
    # query term.
    search_response = client.execute!(
      :api_method => youtube.search.list,
      :parameters => {
        :part => 'snippet',
        :q => opts[:q],
        :maxResults => opts[:max_results]
      }
    )

    videos = []
    channels = []
    playlists = []

    # Add each result to the appropriate list, and then display the lists of
    # matching videos, channels, and playlists.
    search_response.data.items.each do |search_result|
      case search_result.id.kind
        when 'youtube#video'
          videos << "#{search_result.snippet.title} (#{search_result.id.videoId})"
        when 'youtube#channel'
          channels << "#{search_result.snippet.title} (#{search_result.id.channelId})"
        when 'youtube#playlist'
          playlists << "#{search_result.snippet.title} (#{search_result.id.playlistId})"
      end
    end

    puts "Videos:\n", videos, "\n"
    puts "Channels:\n", channels, "\n"
    puts "Playlists:\n", playlists, "\n"
  rescue Google::APIClient::TransmissionError => e
    puts e.result.body
  end
end

main