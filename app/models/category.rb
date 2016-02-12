class Category < ActiveRecord::Base
  has_many :recipe_categories
  has_many :recipes, through: :recipe_categories

   def self.make_categories(categories, recipe)
    category_array = categories.split(", ")
    category_array.each do |new_category|
      old_category = Category.find_by(name: new_category)
      if old_category
        recipe.categories.push(old_category)
      else
        recipe.categories.create(name: new_category)
      end
    end
  end
end
