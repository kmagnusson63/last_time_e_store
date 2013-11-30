class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.string :name
      t.decimal :tax_rate

      t.timestamps
    end
  end
end
