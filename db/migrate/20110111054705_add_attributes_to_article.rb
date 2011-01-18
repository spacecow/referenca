class AddAttributesToArticle < ActiveRecord::Migration
  def self.up
    add_column :articles, :year, :string
  end

  def self.down
    remove_column :articles, :year
  end
end
