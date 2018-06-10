class RelationshipsController < ApplicationController
  def index
    @users = User.where("id != ?", current_user.id)
  end

  def toggle_relationship
    success = false
    msg_start = ""
    other_user = User.find(params["other_user_id"])
    if other_user
      if current_user.following?(other_user)
        current_user.unfollow(other_user)
        msg_start = "Unfollowing"
      else
        current_user.follow(other_user)
        msg_start = "Following"
      end
      success = true
    end
    if success
      render status: 200, json: {
        message: "#{msg_start} #{other_user.name} Succeeded"
      }.to_json
    else
      render status: 422, json: {
        message: "#{msg_start} Failed"
      }.to_json
    end
  end
end