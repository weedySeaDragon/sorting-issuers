class CreateLodges < ActiveRecord::Migration[5.2]
  def change
    create_table :lodges do |t|
      t.string :name
      t.string :nickname
      t.string :designator
      t.integer :number

      t.timestamps
    end
  end
end
