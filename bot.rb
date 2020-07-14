require 'discordrb'
require 'rest-client'
require 'json'
require 'yaml'
require 'nokogiri'
require 'open-uri'
puts 'All dependicies loaded'

CONFIG = YAML.load_file('config.yaml')
puts 'Config loaded from file'

Bot = Discordrb::Commands::CommandBot.new token: CONFIG['token'], client_id: CONFIG['client_id'], prefix: ["<@#{CONFIG['client_id']}> ", CONFIG['prefix']]

puts 'Initial Startup complete, loading all plugins...'

Starttime = Time.now

Dir["#{File.dirname(__FILE__)}/plugins/*.rb"].each { |file| require file }

Dir["#{File.dirname(__FILE__)}/plugins/*.rb"].each do |wow|
  bob = File.readlines(wow) { |line| line.split.map(&:to_s).join }
  command = bob[0][7..bob[0].length]
  command.delete!("\n")
  command = Object.const_get(command)
  Bot.include! command
  puts "Plugin #{command} successfully loaded!"
end

puts 'Done loading plugins! Finalizing start-up'

Bot.server_create do |event|
  event.bot.game = "a mouse is called a mome | on #{event.bot.servers.count} servers | momehelp"
  Bot.channel(730576409491275888).send_embed do |e|
    e.title = 'I did a join'

    e.add_field(name: 'Server Name', value: event.server.name, inline: true)
    e.add_field(name: 'Server ID', value: event.server.id, inline: true)
    e.add_field(name: 'Server Count', value: event.bot.servers.count, inline: true)
    e.add_field(name: 'User Count', value: event.server.members.count, inline: true)

    e.color = '00FF00'
  end
end

Bot.server_delete do |event|
  event.bot.game = "a mouse is called a mome | on #{event.bot.servers.count} servers | momehelp"
  Bot.channel(730576409491275888).send_embed do |e|
    e.title = 'Mome time over! I left a server...'

    e.add_field(name: 'Server Name', value: event.server.name, inline: true)
    e.add_field(name: 'Server ID', value: event.server.id, inline: true)
    e.add_field(name: 'Server Count', value: event.bot.servers.count, inline: true)

    e.color = 'FF0000'
  end
end

Bot.ready do |event|
  event.bot.game = "a mouse is called a mome | on #{event.bot.servers.count} servers | momehelp"
end

puts 'Bot is ready!'
Bot.run
