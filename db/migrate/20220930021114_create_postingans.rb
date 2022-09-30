class CreatePostingans < ActiveRecord::Migration[7.0]
  def change
    create_table :postingans do |t|
      t.string :judul
      t.text :deskripsi

      t.timestamps
    end
  end
end
