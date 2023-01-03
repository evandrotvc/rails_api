class CreateTableMarkSurvivor < ActiveRecord::Migration[7.0]
  def change
    create_table :mark_survivors do |t|
      t.references :person_report, foreign_key: { to_table: 'people' }, index: true
      t.references :person_marked, foreign_key: { to_table: 'people' }, index: true
      t.index  %i[person_report_id person_marked_id], unique: true
      t.timestamps
    end
  end
end
