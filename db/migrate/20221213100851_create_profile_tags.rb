class CreateProfileTags < ActiveRecord::Migration[6.1]
  def change
    create_table :profile_tags do |t|
      t.references :profile, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
