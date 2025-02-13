class CreateEventNotices < ActiveRecord::Migration[6.1]
  def change
    create_table :event_notices do |t|
      t.references :group, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.datetime :event_date

      t.timestamps
    end
  end
end
