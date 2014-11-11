class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.integer :uid
      t.string :token
      t.string :secret
      t.date :updated_at
      t.date :created_at
      t.timestamp
    end
  end
end