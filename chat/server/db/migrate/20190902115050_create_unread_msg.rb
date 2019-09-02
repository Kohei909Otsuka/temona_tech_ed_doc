class CreateUnreadMsg < ActiveRecord::Migration[6.0]
  def change
    create_table :unread_msgs do |t|
      t.references :msg, index: true, foreign_key: true, null: false
      t.references :room, index: true, foreign_key: true, null: false
      t.references :user, index: true, foreign_key: true, null: false
    end
  end
end
