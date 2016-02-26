require 'rails_helper'

RSpec.describe Post, :type => :model do
  let(:post) { build :post }
  let(:valid_attr) { attributes_for :post }
  
  it "creates a new valid post" do
    expect{post.save}.to change{Post.count}.from(0).to(1)
  end

  describe '#published' do
    let!(:unpublished) { create(:post, published: false) }
    let!(:published) { create(:post, published: true) }
    it 'selects only the published posts' do
      expect(Post.published).to eq [published]
    end
  end

  describe '.save' do
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

        context 'when updating existing post' do
          it 'keeps old url' do
            old_url = valid_post.friendly_url
            valid_post.body = "blabla"
            valid_post.save
            expect(valid_post.friendly_url).to eq old_url
          end
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

  describe '.get_by_url' do
    let!(:valid_post) { create :post }
    let(:post_url) { valid_post.friendly_url }
    
    it 'finds by its url' do
      expect(Post.get_by_url(post_url)).to eql(valid_post)
    end
  end

  describe '#render' do
    let(:valid_post) { create(:post, body: body) }
    let(:body) { "testing" }

    it 'renders html from markdown' do
      expect(valid_post.render).to eq "<p>#{body}</p>\n"
    end
  end
end



