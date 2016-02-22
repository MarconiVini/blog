class AddDisabledToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :disabled, :bool, default: :false
    add_index :posts, :disabled

    Post.all.each { |p| p.disabled = false; p.save }
  end
end
