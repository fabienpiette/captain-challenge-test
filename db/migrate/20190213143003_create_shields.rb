class CreateShields < ActiveRecord::Migration[5.2]
  def change
    create_table :shields do |t|
      t.string :name
      t.integer :defense

      t.timestamps
    end
  end
end
