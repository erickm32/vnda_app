class Redirect < ApplicationRecord
  belongs_to :shop

  has_many :sync_jobs # perhaps review this again to avoid orphan syncs

  validates :origin, :destination, presence: true
  validates :origin, :api_id, uniqueness: { scope: :shop_id, allow_nil: true }

  after_save :perform_sync_job_later
  before_destroy :perform_sync_job_now

  private

  def perform_sync_job_later
    SyncRedirectJob.perform_later(self)
  end

  def perform_sync_job_now
    SyncRedirectJob.perform_now(self) # maybe retry because of destroy?
  end
end
