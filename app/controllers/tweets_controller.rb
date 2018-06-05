class TweetsController < ApplicationController
  def index
    @tweets = Tweet.all
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

  def show
    @tweet = Tweet.find(params[:id])
  end

  protected

    def resource_not_found
      message = "The tweet you are looking for could not be found"
      flash[:alert] = message
      redirect_to root_path
    end

  private

    def tweet_params
      params.require(:tweet).permit(:body)
    end
end
