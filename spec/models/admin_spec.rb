require 'rails_helper'

RSpec.describe Admin, :type => :model do
  let(:admin) { build :admin }
  it "creates a new valid admin" do
    expect{admin.save}.to change{Admin.count}.from(0).to(1)
  end

end
