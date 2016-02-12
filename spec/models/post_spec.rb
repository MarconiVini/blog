require 'rails_helper'

RSpec.describe Post, :type => :model do
  let(:post) { build :post }
  it "creates a new valid post" do
    expect{post.save}.to change{Post.count}.from(0).to(1)
  end
end
