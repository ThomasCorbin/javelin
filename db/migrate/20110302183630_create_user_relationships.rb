class CreateUserRelationships < ActiveRecord::Migration
  def self.up
    create_table :user_relationships do |t|
      t.integer :follower_id
      t.integer :followed_id

      t.timestamps
    end

    add_index :user_relationships, :follower_id
    add_index :user_relationships, :followed_id
    add_index :user_relationships, [:follower_id, :followed_id], :unique => true
  end

  def self.down
    drop_table :user_relationships
  end
end
