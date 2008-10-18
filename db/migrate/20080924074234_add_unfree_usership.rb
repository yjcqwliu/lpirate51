class AddUnfreeUsership < ActiveRecord::Migration
  def self.up
     #add_column :userships, :unfree, :string
	 add_column :userships, :robof, :string
  end

  def self.down
     remove_column :userships, :robof
  end
end
