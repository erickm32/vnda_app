require 'rails_helper'

RSpec.describe Redirect, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:shop) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:origin) }
    it { is_expected.to validate_presence_of(:destination) }

    it { is_expected.to validate_uniqueness_of(:origin).scoped_to(:shop_id) }
  end
end
