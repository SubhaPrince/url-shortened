class CreateUrls < ActiveRecord::Migration[5.1]
  def change
    create_table :urls do |t|
      t.string :original_url
      t.string :short_url
      t.integer :pageviews, :default => 0

      t.timestamps null: false
    end
  end
end
