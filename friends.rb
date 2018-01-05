#!/usr/bin/env ruby
require "rubygems"
require "twitter"
 
name = String.new ARGV[0]
 
client = Twitter::REST::Client.new do |config|
  config.consumer_key        = "<YOUR_CONSUMER_KEY>"
  config.consumer_secret     = "<YOUR_CONSUMER_SECRET>"
  config.access_token        = "<YOUR_ACCESS_TOKEN>"
  config.access_token_secret = "<YOUR_ACCESS_TOKEN_SECRET>"
end

peoplethatfollowme = []
peoplethatifollow =[]

client.friend_ids( name ).each_slice( 100 ).with_index do | slice, i |
   client.users( slice ).each_with_index do | f, j |
      peoplethatifollow.push( f.screen_name )
   end
end

client.follower_ids( name ).each_slice( 100 ).with_index do | slice, i |
   client.users( slice ).each_with_index do | f, j |
      peoplethatfollowme.push( f.screen_name )
   end
end

peoplethatifollow.each do | str |
   if ( !peoplethatfollowme.include?( str ) )
      puts "I follow " + str + " but they do not follow me."
   end
end

