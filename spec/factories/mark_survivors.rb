# frozen_string_literal: true

FactoryBot.define do
  factory :mark_survivor do
    person_marked { create(:person) }
    person_report { create(:person) }
  end
end
