class CreateMsg < ActiveRecord::Migration[6.0]
  def change
    create_table :msgs do |t|
      t.text :content, null: false
      t.references :user, index: true, foreign_key: true, null: false
      t.references :room, index: true, foreign_key: true, null: false
    end
  end
end
