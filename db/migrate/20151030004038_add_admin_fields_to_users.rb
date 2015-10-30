class AddAdminFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :admin, :booleen, default: false
  end
end
