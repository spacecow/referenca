class CreateArticles < ActiveRecord::Migration
  def self.up
    create_table :articles do |t|
      t.string :title
      t.text :summarize
      t.string :journal
      t.string :volume
      t.string :start_page
      t.string :end_page
      t.string :pdf
      t.boolean :paper
      t.timestamps
    end
  end

  def self.down
    drop_table :articles
  end
end
