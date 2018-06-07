class CommentsController < ApplicationController

  before_action :set_tweet, only: [ :create ]

  def create
    unless current_user
      flash.now[:alert] = "You need to sign in or sign up before continuing."
      redirect_to new_user_session_path
    else
      @comment = @tweet.comments.build(comment_params)
      @comment.user = current_user

      if @comment.save
        flash[:notice] = "Comment has been added."
      else
        flash.now[:alert] = "Comment has not been added."
      end
      redirect_to tweet_path(@tweet)
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:body)
    end

    def set_tweet
      @tweet = Tweet.find(params[:tweet_id])
    end
end
