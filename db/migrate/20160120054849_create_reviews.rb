class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.references :recipe, null: false
      t.references :user, null: false
      t.integer :rating, null: false
      t.text :comment, null: false

      t.timestamps null: false
    end
  end
end
