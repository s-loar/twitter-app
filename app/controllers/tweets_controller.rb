class TweetsController < ApplicationController
  before_action :set_tweet, only: [ :show, :edit, :update, :destroy ]
  before_action :authenticate_user!, except: [ :show, :index ]

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
  end

  def edit
  end

  def update
    if @tweet.update(tweet_params)
      flash[:success] = "Tweet has been updated"
      redirect_to @tweet
    else
      flash.now[:danger] = "Tweet has not been updated"
      render :edit
    end
  end

  def destroy
    if @tweet.destroy
      flash[:success] = "Tweet has been deleted."
      redirect_to tweets_path
    end
  end

  protected

    def resource_not_found
      flash[:alert] = "The tweet you are looking for could not be found"
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
