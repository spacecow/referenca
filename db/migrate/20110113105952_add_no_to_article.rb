class AddNoToArticle < ActiveRecord::Migration
  def self.up
    add_column :articles, :no, :string
  end

  def self.down
    remove_column :articles, :no
  end
end
