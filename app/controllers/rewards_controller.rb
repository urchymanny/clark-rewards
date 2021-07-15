class RewardsController < ApplicationController
  skip_forgery_protection
  
  def calculate
    puts "Calculating"
    rewards = Rewards::Main.new(params[:data]).perform
    render json: rewards.to_json
  end
end