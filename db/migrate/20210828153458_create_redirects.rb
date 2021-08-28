class CreateRedirects < ActiveRecord::Migration[6.1]
  def change
    create_table :redirects do |t|
      t.string     :origin,      default: ''
      t.string     :destination, default: ''
      t.integer    :api_id
      t.belongs_to :shop

      t.timestamps
    end
  end
end
