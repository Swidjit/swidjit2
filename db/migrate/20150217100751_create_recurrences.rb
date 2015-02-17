class CreateRecurrences < ActiveRecord::Migration
  def change
    create_table :recurrences do |t|
      t.datetime :start_datetime
      t.datetime :end_datetime
      t.datetime :recur_until
      t.string :recurrence_type
      t.string :recur_day
      t.string :recur_week
      t.belongs_to :item
    end
  end
end
