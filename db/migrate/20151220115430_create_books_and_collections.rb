class CreateBooksAndCollections < ActiveRecord::Migration
   	def change
        create_table :books_collections, id: false do |t|
            t.belongs_to :collection, index: true
            t.belongs_to :book, index: true
        end
    end
end
