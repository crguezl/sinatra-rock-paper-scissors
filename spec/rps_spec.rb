require './rps' 
require 'rspec'
require 'rack/test'

set :environment, :test

describe RockPaperScissors::App do
  include Rack::Test::Methods

  def app
    #Sinatra::Application
    RockPaperScissors::App
  end

  it "says throw when visting main page" do
    get '/'
    last_response.should be_ok
    last_response.body.should =~ /throw.rock/
    last_response.body.should =~ /throw.paper/
    last_response.body.should =~ /throw.scissors/
  end

  it "comments the result after throwing" do
    get '/throw/scissors'
    last_response.should be_ok
    last_response.body.should =~ /<li> You choose: scissors/
    last_response.body.should =~ /You\s+tied\s+with\s+the\s+computer |
                                  Nicely\s+done;\s+.+\s+beats        |
                                  Ouch;\s.+\s+beats\s+.+\s+Better\s+luck\s+next\s+time!
                                 /x
  end
end
