class CreateRecipes < ActiveRecord::Migration[6.0]
  def change
    create_table :recipes do |t|
      t.string :title, null: false
      t.text :description
      t.time :duration

      t.timestamps
    end
  end
end
