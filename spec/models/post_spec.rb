require 'rails_helper'

RSpec.describe Post, :type => :model do
  let(:post) { build :post }
  let(:valid_attr) { attributes_for :post }
  
  it "creates a new valid post" do
    expect{post.save}.to change{Post.count}.from(0).to(1)
  end

  describe 'save' do
    describe 'url generation' do
      let(:title) { "Simple Title uniquE " }
      let(:title_latin) { "Não tente AÁàÀâôõãê você" }
      it 'generates unique url' do
        post.title = title
        post.save
        expect(post.friendly_url).to eq "simple-title-unique"
      end

      it 'for latin title' do
        post.title = title_latin
        post.save
        expect(post.friendly_url).to eq "nao-tente-aaaaaooae-voce"
      end

      describe 'unique url' do
        let!(:valid_post) { Post.create(valid_attr) }
        let!(:invalid_post_with_common_url) { Post.create(valid_attr) }
        it 'doesnot allow double posts url' do
          expect(invalid_post_with_common_url.friendly_url).not_to eq valid_post.friendly_url
        end

        context 'when url already exists' do
          it 'generates new url valid url' do
            date = Time.now.strftime("%d-%m-%y")
            expect(invalid_post_with_common_url.friendly_url).to eq("#{valid_post.friendly_url}-#{date}")
          end
        end
      end
    end
  end

  describe 'post finding' do
    let!(:valid_post) { create :post }
    let(:post_url) { valid_post.friendly_url }
    
    it 'finds by its url' do
      expect(Post.get_by_url(post_url)).to eql(valid_post)
    end
  end
end



