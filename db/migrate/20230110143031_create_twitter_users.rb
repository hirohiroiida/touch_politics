class CreateTwitterUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :twitter_users, id: false do |t|
      t.string :name
      t.string :username
      t.integer :user_id, null: false, primary_key: true

      t.timestamp :created_at
    end
  end
end
