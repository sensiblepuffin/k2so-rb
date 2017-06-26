#!/usr/bin/ruby

require 'discordrb'

# Avoid having the token in plaintext
if (File.file?("token"))
	t = File.open("token", "rb")
	token = t.read.gsub("\n","")
	t.close

	i = File.open("client_id", "rb")
	id = i.read.gsub("\n","")
	i.close

	$bot = Discordrb::Commands::CommandBot.new token: token, client_id: id
else
	$bot = Discordrb::Commands::CommandBot.new token: ENV['TOKEN'], client_id: ENV['ID']
end

$bot.ready() do |event|
	$bot.game = "!k2help"
end

def playAudioInChannel(channel, filename)
	$bot.voice_connect(channel)
	sleep(1) 	# Wait for the join channel sound
	voice_bot = $bot.voice(channel)
	voice_bot.volume = 0.25
	voice_bot.play_file("audio/#{filename}")
	voice_bot.destroy
end

$bot.message(with_text: "!k2help") do |event|
	event.respond "I'm not helping you."
end

$bot.message(with_text: "who is champ?") do |event|
	channel = event.user.voice_channel
	if channel
		playAudioInChannel(channel, "whoischamp.mp3")
	else
		event.respond "That question will be answered this Sunday night!"
	end
end

$bot.message(with_text: "yeah boy") do |event|
	channel = event.user.voice_channel
	if channel
		playAudioInChannel(channel, "yeahboy.mp3")
	end
end

$bot.message(with_text: "peacock") do |event|
	channel = event.user.voice_channel
	if channel
		playAudioInChannel(channel, "peacock.mp3")
	else
		event.respond("Nickhil never gets to win anything ever again.")
	end
end

$bot.message(with_text: "why don't we just relax") do |event|
	channel = event.user.voice_channel
	if channel
		playAudioInChannel(channel, "why-don't-we-just-relax.mp3")
	end
end

$bot.message(with_text: "why do you have to be mad?") do |event|
	channel = event.user.voice_channel
	if channel
		playAudioInChannel(channel, "why-you-heff-to-be-mehd.mp3")
	end
end

$bot.run 
