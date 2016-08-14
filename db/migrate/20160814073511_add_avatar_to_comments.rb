class AddAvatarToComments < ActiveRecord::Migration
  def change
    add_column :comments, :avatar, :string
  end
end
