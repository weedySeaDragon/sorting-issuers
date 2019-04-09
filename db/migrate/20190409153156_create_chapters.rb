class CreateChapters < ActiveRecord::Migration[5.2]

  def change
    create_table :chapters do |t|

      t.references :lodge, foreign_key: true
      t.string :name
      t.string :designator
      t.integer :number

      t.timestamps
    end
  end
end
