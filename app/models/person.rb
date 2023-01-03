# frozen_string_literal: true

class Person < ApplicationRecord
  validates :name, :latitude, :longitude, presence: true

  has_many :mark_survivors, foreign_key: :person_report_id,
    dependent: :destroy, inverse_of: false
  has_many :survivors_marked, class_name: 'MarkSurvivor', foreign_key: :person_marked_id,
    inverse_of: false, dependent: :destroy

  enum status: {
    survivor: 'survivor', infected: 'infected', dead: 'dead'
  }, _default: :survivor

  def create_mark_survivor(person_infeceted)
    MarkSurvivor.create!(
      person_report: self,
      person_marked: person_infeceted
    )
  end

  def closest_person
    peoples = Person.where.not(id:)

    hash = calculate_distance(peoples)

    hash.select { |_, value| value == hash.values.min }.first
  end

  def calculate_distance(peoples)
    hash = {}
    peoples.index_with do |person|
      hash[person] = Geocoder::Calculations
        .distance_between([person.latitude, person.longitude], [latitude, longitude])
    end
  end
end
