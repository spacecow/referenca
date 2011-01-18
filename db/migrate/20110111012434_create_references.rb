class CreateReferences < ActiveRecord::Migration
  def self.up
    create_table :references do |t|
      t.integer :article_id
      t.integer :referenced_article_id

      t.timestamps
    end
  end

  def self.down
    drop_table :references
  end
end
