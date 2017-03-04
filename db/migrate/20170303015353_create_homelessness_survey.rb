class CreateHomelessnessSurvey < ActiveRecord::Migration[5.0]
  def change
    create_table :homelessness_surveys do |t|
      t.integer :_id
      t.string :category
      t.string :sub_category
      t.integer :frequency
      t.integer :percent
      t.datetime :survey_year
    end
  end
end
