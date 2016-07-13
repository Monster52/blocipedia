class ChangeRoleOnUsers < ActiveRecord::Migration
  def up
    change_column_null :users, :role, false
    change_column_default :users, :role, 0
  end
  
  def down
    change_column_null :users, :role, true
    change_column_default :users, :role, nil
  end
end
