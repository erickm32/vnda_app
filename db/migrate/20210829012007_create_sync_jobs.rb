class CreateSyncJobs < ActiveRecord::Migration[6.1]
  def change
    create_table :sync_jobs do |t|
      t.integer     :status, default: 0
      t.integer     :operation, default: 0
      t.integer     :api_id
      t.text        :params
      t.text        :sync_errors
      t.belongs_to  :redirect

      t.timestamps
    end
  end
end
