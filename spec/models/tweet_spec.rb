require 'rails_helper'

RSpec.describe Tweet, type: :model do
  it { should validate_presence_of(:body) }
  it { should allow_value("blahblah").for(:body) }
  it { should_not allow_value("blahblah" * 40).for(:body) }
end
