class TweetsController < ApplicationController
  # before_action :set_tweet, only: [ :show, :edit, :update ]

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

  def edit
    @tweet = Tweet.find(params[:id])
  end

  def update
    @tweet = Tweet.find(params[:id])
    if @tweet.update(tweet_params)
      flash[:success] = "Tweet has been updated"
      redirect_to @tweet
    else
      flash.now[:danger] = "Tweet has not been updated"
      render :edit
    end
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

    def set_tweet
      @tweet = Tweet.find(params[:id])
    end
end
