class CreateTurns < ActiveRecord::Migration[6.0]
  def change
    create_table :turns do |t|
      t.references :contract, null: false, foreign_key: true
      t.datetime :date_hour
      t.string :availables
      t.references :user, null: true, foreign_key: true

      t.timestamps
    end
  end
end
