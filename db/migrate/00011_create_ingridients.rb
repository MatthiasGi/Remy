class CreateIngridients < ActiveRecord::Migration[6.0]
  def change
    create_table :ingridients do |t|
      t.belongs_to :recipe
      
      t.string :label, null: false
      t.string :quantity

      t.timestamps
    end
  end
end
