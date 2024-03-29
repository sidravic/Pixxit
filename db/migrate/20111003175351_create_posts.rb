class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.string :title
      t.text :description
      t.integer :user_id
      t.boolean :published, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end
