class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
      t.references :recipe, null: false
      t.string :name, null: false
      t.integer :amount, null: false
      t.string :unit, null: false

      t.timestamps null: false
    end
  end
end
