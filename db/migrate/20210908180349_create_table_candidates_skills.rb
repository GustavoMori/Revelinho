class CreateTableCandidatesSkills < ActiveRecord::Migration[6.1]
  def change
    create_table :candidates_skills, id: false do |t|
      t.references :candidate, type: :uuid, foreign_key: true
      t.references :skill, type: :uuid, foreign_key: true
      t.index [:candidate_id, :skill_id], unique: true
      #t.belongs_to


      t.timestamps
    end
    #add_index :candidates_skills, [:candidates_id, :skills_id], unique: true ]
    #add_index :candidates_skills, :candidate_id, unique: true
    #add_index :candidates_skills, :skill_id, unique: true
  end
end
