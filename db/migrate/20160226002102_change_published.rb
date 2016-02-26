class ChangePublished < ActiveRecord::Migration[5.0]
  def change
    remove_index :posts, :disabled
    remove_column :posts, :disabled

    add_column :posts, :published, :bool, default: :false
    add_index :posts, :published

    Post.all.each { |p| p.published = false; p.save }
  end
end
