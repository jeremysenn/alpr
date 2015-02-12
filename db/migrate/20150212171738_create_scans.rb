class CreateScans < ActiveRecord::Migration
  def change
    create_table :scans do |t|
      t.string :name
      t.string :results

      t.timestamps null: false
    end
  end
end
