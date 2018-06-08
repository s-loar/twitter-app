require "rails_helper"

RSpec.describe "Tweets", type: :request do

  before do
    @jake = User.create!(email: "jake@example.com", password: "password", name: "Jake")
    @sally = User.create!(email: "sally@example.com", password: "password", name: "Sally")
    @tweet = Tweet.create!(body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", user: @jake)
  end

  describe 'GET /tweets/:id' do
    context 'with an existing tweet' do
      before { get "/tweets/#{@tweet.id}" }

      it "handles existing tweet" do
        expect(response.status).to eq 200
      end
    end

    context 'with non-existing tweet' do
      before { get "/tweets/0" }

      it "handles non-existing tweet" do
        expect(response.status).to eq 302
        flash_message = "The tweet you are looking for could not be found"
        expect(flash[:alert]).to eq flash_message
      end
    end
  end

  describe 'GET /tweets/:id/edit' do
    context 'with a non-signed in user' do
      before { get "/tweets/#{@tweet.id}/edit" }
      it "redirects to the sign in page" do
        expect(response.status).to eq( 302)
        flash_message = "You need to sign in or sign up before continuing."
        expect(flash[:alert]).to eq flash_message
      end
    end
    context 'with a signed in user who is not the owner' do
      before  do
        login_as @sally
        get "/tweets/#{@tweet.id}/edit"
      end
      it "redirects to the home page" do
        expect(response.status).to eq( 302)
        flash_message = "You can only edit your own tweets."
        expect(flash[:alert]).to eq flash_message
      end
    end
    context 'with a signed in user who is the owner' do
      before do
        login_as @jake
        get "/tweets/#{@tweet.id}/edit"
      end
      it "allows tweet to be edited" do
        expect(response.status).to eq 200
      end
    end
  end

  describe 'DELETE /tweets/:id' do
    context 'with a non-signed in user' do
      before { delete "/tweets/#{@tweet.id}" }
      it "redirects to the sign in page" do
        expect(response.status).to eq( 302)
        flash_message = "You need to sign in or sign up before continuing."
        expect(flash[:alert]).to eq flash_message
      end
    end
    context 'with a signed in user who is not the owner' do
      before  do
        login_as @sally
        delete "/tweets/#{@tweet.id}"
      end
      it "redirects to the home page" do
        expect(response.status).to eq( 302)
        flash_message = "You can only delete your own tweets."
        expect(flash[:alert]).to eq flash_message
      end
    end
    context 'with signed in user who is the owner' do
      before do
        login_as @jake
        delete "/tweets/#{@tweet.id}"
      end
      it "successfully deletes the tweet" do
        expect(response.status).to eq 302
        flash_message = "Tweet has been deleted."
        expect(flash[:success]).to eq flash_message
      end
    end
  end

end

