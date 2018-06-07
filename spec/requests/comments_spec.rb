require "rails_helper"

RSpec.describe "Comments", type: :request do

  before do
    @jake = User.create!(email: "jake@example.com", password: "password")
    @sally = User.create!(email: "sally@example.com", password: "password")
    @tweet = Tweet.create!(body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", user: @jake)
  end

  describe 'POST /tweets/:id/comments' do
    context 'with signed in user' do
      before do
        login_as @sally
        post "/tweets/#{@tweet.id}/comments", params: {comment: {body: "Awesome tweet."}}
      end
      it "successfully creates the comment" do
        flash_message = "Comment has been added."
        expect(response).to redirect_to(tweet_path(@tweet.id))
        expect(response.status).to eq(302)
        expect(flash[:notice]).to eq flash_message
      end
    end

    context 'with a non-signed in user' do
      before do
        post "/tweets/#{@tweet.id}/comments", params: {comment: {body: "Awesome tweet."}}
      end

      it "redirects to the sign in page" do
        flash_message = "You need to sign in or sign up before continuing."
        expect(response).to redirect_to(new_user_session_path)
        expect(response.status).to eq(302)
        expect(flash[:alert]).to eq flash_message
      end
    end
  end
end