class SyncJob < ApplicationRecord
  belongs_to :redirect

  enum status: { waiting: 0, processing: 1, success: 2, failed: 3 }
  enum operation: { create: 0, update: 1, destroy: 2 }, _suffix: 'action'
end
