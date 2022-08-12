class CreateContracts < ActiveRecord::Migration[6.0]
  def change
    create_table :contracts do |t|
      t.string :name
      t.date :start_date
      t.date :end_date
      t.integer :start_wday
      t.string :start_hour
      t.string :end_hour
      t.integer :end_wday
      t.references :requested_by, foreign_key: { to_table: :users }
      t.references :accepted_by, foreign_key: { to_table: :users }
      t.integer :state

      t.timestamps
    end
  end
end
