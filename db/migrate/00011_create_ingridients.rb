class CreateIngridients < ActiveRecord::Migration[6.0]
  def change
    create_table :ingridients do |t|
      t.belongs_to :recipe

      t.string :label
      t.string :quantity

      t.timestamps
    end
  end
end
