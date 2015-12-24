class AddBookToComments < ActiveRecord::Migration
  def change
    add_reference :comments, :book, index: true
    add_foreign_key :comments, :books
  end
end
