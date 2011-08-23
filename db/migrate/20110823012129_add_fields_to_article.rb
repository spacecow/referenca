class AddFieldsToArticle < ActiveRecord::Migration
  def self.up
    add_column :articles, :publisher, :string
    add_column :articles, :edition, :string
  end

  def self.down
    remove_column :articles, :edition
    remove_column :articles, :publisher
  end
end
