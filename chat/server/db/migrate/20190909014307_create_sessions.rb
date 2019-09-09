class CreateSessions < ActiveRecord::Migration[6.0]
  def change
    create_table :sessions, id: :string, primary_key: :session_id do |t|
      t.string :value, null: false
    end
  end
end
