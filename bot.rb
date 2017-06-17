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

bot.message(with_text: "!k2help") do |event|
	event.respond "I'm not helping you."
end

bot.message(with_text: "who is champ?") do |event|
	channel = event.user.voice_channel
	next "You're not in any voice channel!" unless channel
	bot.voice_connect(channel)
	"Connected to voice channel: #{channel.name}"
	voice_bot = bot.voice(channel)
	voice_bot.volume = 0.5
	voice_bot.play_file('audio/whoischamp.mp3')
	voice_bot.destroy
end

bot.run 

bot.game("!k2help")
