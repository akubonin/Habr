class CreateCategoriesPosts < ActiveRecord::Migration
  def change
    create_table :categories_posts do |t|
      t.belongs_to :post, index: true
      t.belongs_to :category, index: true
    end
  end
end
