class CreateCatalogs < ActiveRecord::Migration
  def change
    create_table :catalogs do |t|
      t.belongs_to :library, index: true
      t.belongs_to :book, index: true
      t.integer :search_count
      t.integer :have_now
      t.integer :have_total

      t.timestamps null: false
    end
  end
end
