class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.integer :uid
      t.string :token
      t.string :secret
      t.datetime :updated_at
      t.datetime :created_at
      t.timestamp
    end
  end
end