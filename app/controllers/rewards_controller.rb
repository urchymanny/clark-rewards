class RewardsController < ApplicationController
  skip_forgery_protection
  
  def calculate
    rewards = Rewards::Main.new(params[:data]).perform
    render json: rewards.to_json
  end

  def file_calculate
    data = params[:file].read
    rewards = Rewards::Main.new(data).perform
    render json: rewards.to_json
  end
end