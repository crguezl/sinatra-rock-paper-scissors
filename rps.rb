module Example
  require 'sinatra'
    class App < Sinatra::Base

    # before we process a route, we'll set the response as
    # plain text and set up an array of viable moves that
    # a player (and the computer) can perform
    before do
      content_type :html
      @defeat = {rock: :scissors, paper: :rock, scissors: :paper}
      @throws = @defeat.keys
    end

    get '/throw/:type' do
      # the params[] hash stores querystring and form data.
      player_throw = params[:type].to_sym

      # in the case of a player providing a throw that is not valid,
      # we halt with a status code of 403 (Forbidden) and let them
      # know they need to make a valid throw to play.
      if !@throws.include?(player_throw)
        halt 403, "<a href='/'>You must throw one of the following: #{@throws}</a>"
      end

      # now we can select a random throw for the computer
      computer_throw = @throws.sample

      # compare the player and computer throws to determine a winner
      if player_throw == computer_throw
        '<a href="/">You tied with the computer. Try again!</a>'
      elsif computer_throw == @defeat[player_throw]
        "<a href=\"/\">Nicely done; #{player_throw} beats #{computer_throw}!</a>"
      else
        "<a href=\"/\">Ouch; #{computer_throw} beats #{player_throw}. Better luck next time!</a>"
      end
    end

    get '/*' do
      '''
    <ul> 
    <li><a href="throw/rock">rock</a>
    <li><a href="throw/paper">paper</a>
    <li><a href="throw/scissors">scissors</a>
    </ul>
    '''
    end
  end
end
