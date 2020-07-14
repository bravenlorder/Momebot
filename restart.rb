module Restart
  extend Discordrb::Commands::CommandContainer

  command(:restart) do |event|
    unless event.user.id == CONFIG['owner_id']
      event.respond "You can't update! (If you are the owner of the bot, you did not configure properly! Otherwise, stop trying to update the bot!)"
      break
    end
    event.respond 'Restarting the bot without updating...'
    sleep 1
    exec('ruby bot.rb')
  end

  command(:update) do |event|
    unless event.user.id == CONFIG['owner_id']
      event.respond "You can't update! (If you are the owner of the bot, you did not configure properly! Otherwise, stop trying to update the bot!)"
      return
    end
    event.respond 'Restarting and Updating!'
    sleep 1
    `git pull`
    exec('ruby bot.rb')
  end

  command(:shoo) do |event|
    break unless event.user.id == CONFIG['owner_id']
    event.send_temporary_message('I am shutting dowm, it\'s been a long run folks!', 3)
    sleep 3
    exit
  end
end
