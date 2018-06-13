class AddLikersCountToTweet < ActiveRecord::Migration[5.1]
  def change
    add_column :Tweets, :likers_count, :integer, :default => 0
  end
end
