module Ping
  extend Discordrb::Commands::CommandContainer
command(:ping, min_args: 0, max_args: 1) do |event, noedit|
    event.respond "Pong! Time taken: #{((Time.now - event.timestamp) * 1000).to_i} milliseconds."
  end
end
