class AddDescToUsers < ActiveRecord::Migration
  def change
    add_column :users, :desc, :string
  end
end
