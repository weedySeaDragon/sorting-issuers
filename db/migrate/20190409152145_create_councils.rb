class CreateCouncils < ActiveRecord::Migration[5.2]
  def change
    create_table :councils do |t|
      t.string :designator
      t.integer :number

      t.timestamps
    end
  end
end
