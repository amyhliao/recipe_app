class CreateRecipeCategories < ActiveRecord::Migration
  def change
    create_table :recipe_categories do |t|
      t.references :recipe, null: false, index: true
      t.references :category, null: false, index: true

      t.timestamps null: false
    end
  end
end
