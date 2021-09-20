class CreateTableSkills < ActiveRecord::Migration[6.1]
  def change
    create_table :skills, id: :uuid do |t|
      t.string :name, null: false
      t.timestamps
    end
    add_index :skills, :name, unique: true
  end
end
