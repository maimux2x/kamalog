class AddCaptionToPhotos < ActiveRecord::Migration[8.1]
  def change
    add_column :photos, :caption, :string
  end
end
