class CreateTweets < ActiveRecord::Migration[7.0]
  def change
    create_table :tweets, id: false do |t|
      t.bigint :tweet_id, null: false, primary_key: true
	    t.text :text
	    t.datetime :start_time
      t.references :twitter_user, null: false, foreign_key: { primary_key: :user_id }

      t.timestamps
    end
  end
end
