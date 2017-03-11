class CreateErpArticlesComments < ActiveRecord::Migration[5.0]
  def change
    create_table :erp_articles_comments do |t|

      t.timestamps
    end
  end
end
