#!/usr/bin/ruby

require 'discordrb'

# Avoid having the token in plaintext
if (File.file?("token"))
	f = File.open("token", "rb")
	token = f.read.gsub("\n","")
	bot = Discordrb::Bot.new token: token, client_id: 264450615139237899
	f.close	
else
	bot = Discordrb::Bot.new token: ENV['TOKEN'], client_id: 264450615139237899
end

bot.message(with_text: "Hello!") do |event|
	event.respond "Hi, #{event.user.name}!"
end

bot.run 
