class AddGroupIdToArticles < ActiveRecord::Migration
  def self.up
    add_column :articles, :group_id, :integer
  end

  def self.down
    remove_column :articles, :group_id
  end
end
