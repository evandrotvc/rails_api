# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Person do
  subject(:person) { build(:person) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:latitude) }
    it { is_expected.to validate_presence_of(:longitude) }
  end

  #   describe 'associations' do
  #     it { is_expected.to have_many(:group_documents) }
  #   end

  describe 'person create' do
    before { person.save }

    it { is_expected.to be_persisted }
  end
end
