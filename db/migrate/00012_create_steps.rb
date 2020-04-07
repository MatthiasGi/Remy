class CreateSteps < ActiveRecord::Migration[6.0]
  def change
    create_table :steps do |t|
      t.belongs_to :recipe

      t.integer :number
      t.text :description

      t.timestamps
    end
  end
end
