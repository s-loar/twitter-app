require "rails_helper"

RSpec.describe "Articles", type: :request do

  before do
    @tweet = Tweet.create!(body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.")
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

end
