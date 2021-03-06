class TweetsController < ApplicationController
  before_action :set_tweet, only: [ :show, :edit, :update, :destroy, :likes, :undo_likes ]
  before_action :authenticate_user!, except: [ :show, :index ]

  def index
    if current_user
      @tweets = current_user.twitter_feed.paginate(:page => params[:page], :per_page => 3)
    end
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user = current_user
    if @tweet.save
      flash[:success] = "Tweet has been posted"
      redirect_to tweets_path
    else
      flash.now[:danger] = "Tweet has not been posted"
      render :new
    end
  end

  def show
    @comment = @tweet.comments.build # for the new one
    @comments = @tweet.comments
  end

  def edit
    unless @tweet.user == current_user
      flash[:alert] = "You can only edit your own tweets."
      redirect_to root_path
    end
  end

  def update
    unless @tweet.user == current_user
      flash[:alert] = "You can only edit your own tweets."
      redirect_to root_path
    else
      if @tweet.update(tweet_params)
        flash[:success] = "Tweet has been updated"
        redirect_to @tweet
      else
        flash.now[:danger] = "Tweet has not been updated"
        render :edit
      end
    end
  end

  def destroy
    unless @tweet.user == current_user
      flash[:alert] = "You can only delete your own tweets."
      redirect_to root_path
    else
      if @tweet.destroy
        flash[:success] = "Tweet has been deleted."
        redirect_to tweets_path
      end
    end
  end

  def likes
    current_user.like!(@tweet)
    flash[:success] = "Tweet has been Liked"
    redirect_to root_path
  end

  def undo_likes
    current_user.unlike!(@tweet)
    flash[:success] = "Tweet has been unliked"
    redirect_to root_path
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
