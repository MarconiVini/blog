require 'rails_helper'

RSpec.describe "HomePosts", :type => :request do
  let!(:post) { create(:post) }

  describe "GET index" do
    let!(:post_published) { create(:published_post) }
    it "returns published posts" do
      get "/"
      expect(assigns(:posts)).to eq([post_published])
    end
  end

  describe "GET show" do
    it "returns http success" do
      get "/posts/#{post.friendly_url}"
      expect(response).to have_http_status(:success)
    end

    it "returns http success" do
      get "/posts/#{post.friendly_url}"
      expect(assigns :post).to eq post
    end
  end
end
