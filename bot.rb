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

bot.ready() do |event|
	bot.game = "!k2help"
end

def playAudioInChannel(channel, filename)
	bot.voice_connect(channel)
	voice_bot = bot.voice(channel)
	voice_bot.volume = 0.25
	voice_bot.play_file("audio/#{filename}")
	voice_bot.destroy
end

bot.message(with_text: "!k2help") do |event|
	event.respond "I'm not helping you."
end

bot.message(with_text: "who is champ?") do |event|
	channel = event.user.voice_channel
	if channel
		playAudioInChannel(channel, "whoischamp.mp3")
	else
		event.respond "That question will be answered this Sunday night!"
	end
end

bot.message(with_text: "why do you have to be mad?") do |event|
	channel = event.user.voice_channel
	if channel
		playAudioInChannel(channel, "why-you-heff-to-be-mehd.mp3")
	end
end

bot.run 
