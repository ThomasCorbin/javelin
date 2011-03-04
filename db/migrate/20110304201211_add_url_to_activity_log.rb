class AddUrlToActivityLog < ActiveRecord::Migration
  def self.up
    add_column :activity_logs, :url, :text
  end

  def self.down
    remove_column :activity_logs, :url
  end
end
