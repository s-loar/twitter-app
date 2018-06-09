class RelationshipsController < ApplicationController
  def index
    @users = User.where("id != ?", current_user.id)
  end

  def create
    success = false
    user_to_follow = User.find(params["followed_id"])
    if user_to_follow
      current_user.follow(user_to_follow) unless current_user.following?(user_to_follow)
      success = true
    end
    if success
      render status: 200, json: {
        message: "Following #{user_to_follow.name} Succeeded"
      }.to_json
    else
      render status: 422, json: {
        message: "Following Failed"
      }.to_json
    end
  end
end