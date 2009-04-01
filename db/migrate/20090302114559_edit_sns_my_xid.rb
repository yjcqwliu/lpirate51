class EditSnsMyXid < ActiveRecord::Migration
  def self.up
    remove_column :sns_commits, :sns_user_xid
    add_column :sns_commits, :sns_user_xid, :string
  end

  def self.down
    remove_column :sns_commits, :sns_user_xid
    add_column :sns_commits, :sns_user_xid, :integer
  end
end
