# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_210_914_142_641) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'pgcrypto'
  enable_extension 'plpgsql'

  create_table 'candidates', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.string 'name'
    t.string 'email', null: false
    t.date 'birthday'
    t.string 'cellphone'
    t.string 'careers'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['careers'], name: 'index_candidates_on_careers'
    t.index ['email'], name: 'index_candidates_on_email', unique: true
  end

  create_table 'candidates_skills', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.uuid 'candidate_id'
    t.uuid 'skill_id'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index %w[candidate_id skill_id], name: 'index_candidates_skills_on_candidate_id_and_skill_id', unique: true
    t.index ['candidate_id'], name: 'index_candidates_skills_on_candidate_id'
    t.index ['skill_id'], name: 'index_candidates_skills_on_skill_id'
  end

  create_table 'skills', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.string 'name', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['name'], name: 'index_skills_on_name', unique: true
  end

  add_foreign_key 'candidates_skills', 'candidates'
  add_foreign_key 'candidates_skills', 'skills'
end
