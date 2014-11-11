class CreatingTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :text
      t.integer :user_id
      t.datetime :created_at
      t.timestamp
    end
  end
end
