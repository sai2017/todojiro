class CreateJiros < ActiveRecord::Migration[5.2]
  def change
    create_table :jiros do |t|
      t.string :name, null: false
      t.boolean :is_done, default: false, null: false

      t.timestamps
    end
  end
end