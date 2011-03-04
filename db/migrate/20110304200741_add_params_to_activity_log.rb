class AddParamsToActivityLog < ActiveRecord::Migration
  def self.up
    add_column :activity_logs, :params, :text
  end

  def self.down
    remove_column :activity_logs, :params
  end
end
