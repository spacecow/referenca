class AddOwnerAndPrivateToArticle < ActiveRecord::Migration
  def self.up
    add_column :articles, :owner_id, :integer
    add_column :articles, :private, :boolean
  end

  def self.down
    remove_column :articles, :private
    remove_column :articles, :owner_id
  end
end
