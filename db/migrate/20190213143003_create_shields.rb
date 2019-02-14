class CreateShields < ActiveRecord::Migration[5.2]
  def change
    create_table :shields do |t|
      t.string :name, null: false
      t.integer :defense, null: false

      t.timestamps
    end
  end
end
