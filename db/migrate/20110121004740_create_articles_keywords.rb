class CreateArticlesKeywords < ActiveRecord::Migration
  def self.up
    create_table :articles_keywords do |t|
      t.integer :article_id
      t.integer :keyword_id

      t.timestamps
    end
  end

  def self.down
    drop_table :articles_keywords
  end
end
