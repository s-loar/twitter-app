require 'rails_helper'

RSpec.describe UserRelationship, type: :model do
  it { should validate_presence_of(:follower_id) }
  it { should validate_presence_of(:followed_id) }
end