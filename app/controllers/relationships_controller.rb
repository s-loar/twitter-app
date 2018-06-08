class RelationshipsController < ApplicationController
  def index
    @users = User.where("id != ?", current_user.id)
  end

  def create
    # byebug
    user_to_follow = User.find(params["followed_id"])
    if user_to_follow
      # follower.follow(user_to_follow) unless follower.following?(user_to_follow)
    end
  end
end