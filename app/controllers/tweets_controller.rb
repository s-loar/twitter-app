class TweetsController < ApplicationController
  def index
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    if @tweet.save
      flash[:success] = "Tweet has been posted"
      redirect_to tweets_path
    else
      flash.now[:danger] = "Tweet has not been posted"
      render :new
    end
  end

  private

    def tweet_params
      params.require(:tweet).permit(:body)
    end
end
