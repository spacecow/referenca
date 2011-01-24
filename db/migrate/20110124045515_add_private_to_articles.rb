class AddPrivateToArticles < ActiveRecord::Migration
  def self.up
    add_column :articles, :private, :boolean
  end

  def self.down
    remove_column :articles, :private
  end
end
