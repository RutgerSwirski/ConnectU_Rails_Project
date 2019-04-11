class AddColumnsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :profile_picture, :string, default: 'default-profile-pic-png-8.png'
    add_column :users, :description, :text
  end
end

