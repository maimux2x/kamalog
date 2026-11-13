class RenameLogPhotosToPhotos < ActiveRecord::Migration[8.1]
  def change
    rename_table :log_photos, :photos
  end
end
