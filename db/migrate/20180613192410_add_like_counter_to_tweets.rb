class AddLikeCounterToTweets < ActiveRecord::Migration[5.1]
  def change
    add_column :tweets, :likers_count, :integer, :default => 0
  end
end
