module RockPaperScissors
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

    get '/throw/:type' do |type|
      @player_throw = type.to_sym

      # in the case of a player providing a throw that is not valid,
      # we halt with a status code of 403 (Forbidden) and let them
      # know they need to make a valid throw to play.
      if !@throws.include?(@player_throw)
        halt 403, "<a href='/'>You must throw one of the following: #{@throws}</a>"
      end

      # now we can select a random throw for the computer
      @computer_throw = @throws.sample

      # compare the player and computer throws to determine a winner
      if @player_throw == @computer_throw
        @answer = 'You tied with the computer.'
        erb :play
      elsif @computer_throw == @defeat[@player_throw]
        @answer = "Nicely done; #{@player_throw} beats #{@computer_throw}"
        erb :play
      else
        @answer = "Ouch; #{@computer_throw} beats #{@player_throw}. Better luck next time!."
        erb :play
      end
    end

    get '/*' do
      erb :root
    end
  end
end
