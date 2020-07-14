module Gender
  extend Discordrb::Commands::CommandContainer

  command(:gender) do |event|
    choice = rand(0..1)
    begin
      event.channel.send_embed do |e|
        e.title = 'What\'s your gender?'

        if choice.zero?
          e.description = 'Your gender is: male!'
          e.color = '0000ff'
        else
          e.description = 'Your gender is: female!'
		  e.color = 'ffc0cb'
        end
      end
    rescue Discordrb::Errors::NoPermission
      event.respond 'no u.'
    end
  end
end
