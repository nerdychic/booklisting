class AddNameAndAuthorToBooks < ActiveRecord::Migration
  def change
    add_column :books, :name, :string
    add_column :books, :author, :string
  end
end
