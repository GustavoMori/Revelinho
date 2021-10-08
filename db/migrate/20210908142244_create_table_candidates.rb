# frozen_string_literal: true

class CreateTableCandidates < ActiveRecord::Migration[6.1]
  def change
    create_table :candidates, id: :uuid do |t|
      t.string :name
      t.string :email, null: false # , index: { unique: true }
      t.date :birthday
      t.string :cellphone
      t.string :careers # , index: true

      t.timestamps
    end
    add_index :candidates, :email, unique: true
    add_index :candidates, :careers
  end
end
