class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.references :user, null: false
      t.string :title, null: false
      t.text :description, null: false
      t.text :instruction, null: false
      t.integer :prep_time, null: false
      t.integer :cook_time, null: false
      t.integer :total_time, null: false

      t.timestamps null: false
    end
  end
end
