class AddFriendlyUrlToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :friendly_url, :string
    add_index :posts, :friendly_url, unique: true
  end
end
