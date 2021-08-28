require 'rails_helper'

RSpec.describe Shop, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:redirects) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:token) }
    it { is_expected.to validate_presence_of(:remote_id) }

    it { is_expected.to validate_uniqueness_of(:name) }
    it { is_expected.to validate_uniqueness_of(:token) }
    it { is_expected.to validate_uniqueness_of(:remote_id) }
  end
end
