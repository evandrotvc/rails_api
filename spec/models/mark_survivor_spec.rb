# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MarkSurvivor do
  subject(:mark_survivor) { build(:mark_survivor) }

  describe 'associations' do
    it { is_expected.to belong_to(:person_report) }
    it { is_expected.to belong_to(:person_marked) }
  end

  describe 'mark_survivor create' do
    context 'when mark_survivor is persisted' do
      before { mark_survivor.save }

      it { is_expected.to be_persisted }
    end

    context 'when a person report as infected the same person one more time' do
      let(:mark_survivor2) do
        described_class.new(person_marked: mark_survivor.person_marked,
          person_report: mark_survivor.person_report)
      end

      before { mark_survivor.save }

      it 'will raise exception', :aggregate_failures do
        expect { mark_survivor2.save! }.to raise_error(ActiveRecord::RecordNotUnique)
      end
    end
  end
end
