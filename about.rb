module About
  extend Discordrb::Commands::CommandContainer

  command(%i[help commands about]) do |event|
    begin
      event.channel.send_embed do |embed|
        embed.title = 'Welcome to Momebot'
        embed.colour = 0xd084
        embed.description = 'Where mouses can finally be called momes!'

        embed.add_field(name: '!help', value: 'Show help', inline: true)
        embed.add_field(name: '!ping', value: 'Am alive?', inline: true)
        embed.add_field(name: '!stats', value: 'do the boing', inline: true)
        embed.add_field(name: '!gender', value: "Shows your gender", inline: true)
      end
    rescue Discordrb::Errors::NoPermission
      event.respond 'Hello, in order for me to run most commands, I need the `Embed Links` permission, may you please grant that? Thanks, appreciate ya.'
    end
  end


  command(:stats) do |event|
    t = Time.now - Starttime
    mm, ss = t.divmod(60)
    hh, mm = mm.divmod(60)
    dd, hh = hh.divmod(24)
    days = format("%d days\n", dd) if dd != 0
    hours = format("%d hours\n", hh) if hh != 0
    mins = format("%d minutes\n", mm) if mm != 0
    secs = format('%d seconds', ss) if ss != 0

    begin
      event.channel.send_embed do |e|
        e.title = 'Momebot - A basic, yet functioning, discord bot'

        e.add_field(name: 'Authors', value: '<@207909015173332992> & <@116013677060161545>', inline: true)
        e.add_field(name: 'Code', value: '[View code on GitHub](https://github.com/bravencoder/Momebot)', inline: true)
        e.add_field(name: 'Library', value: 'discordrb 3.2.1', inline: true)
        e.add_field(name: 'Uptime', value: "#{days}#{hours}#{mins}#{secs}", inline: true)
        e.add_field(name: 'Server Count', value: event.bot.servers.count, inline: true)
        e.add_field(name: 'Total User Count', value: event.bot.users.count, inline: true)
        e.color = '00FF00'
      end
    rescue Discordrb::Errors::NoPermission
      event.respond "SYSTEM ERRor, I CANNot SEND THE EMBED, EEEEE. Can I please have the 'Embed Links' permission? Thanks, appriciate ya."
    end
  end
end
