class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_salt
      t.string :password_hash

      t.timestamps
    end
  end
end
