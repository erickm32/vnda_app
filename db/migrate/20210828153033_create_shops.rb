class CreateShops < ActiveRecord::Migration[6.1]
  def change
    create_table :shops do |t|
      t.string  :name,      default: ''
      t.integer :remote_id
      t.string  :token,     default: ''
      t.string  :url,       default: ''

      t.timestamps
    end
  end
end
