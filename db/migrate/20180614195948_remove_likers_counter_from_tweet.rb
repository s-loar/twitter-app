class RemoveLikersCounterFromTweet < ActiveRecord::Migration[5.1]
  def change
    remove_column :tweets, :likers_count, :integer
  end
end
