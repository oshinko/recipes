class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :uid
      t.string :nickname
      t.string :name
      t.string :image

      t.timestamps
    end
    add_index :users, :uid, unique: true
    add_index :users, :nickname, unique: true
  end
end
