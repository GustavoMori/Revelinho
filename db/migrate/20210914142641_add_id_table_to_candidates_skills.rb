class AddIdTableToCandidatesSkills < ActiveRecord::Migration[6.1]
  def change
    add_column :candidates_skills, :id, :uuid, default: "gen_random_uuid()"

    execute "ALTER TABLE candidates_skills ADD PRIMARY KEY (id);"
  end
end
