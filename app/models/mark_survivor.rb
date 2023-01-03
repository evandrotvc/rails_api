# frozen_string_literal: true

class MarkSurvivor < ApplicationRecord
  belongs_to :person_marked, class_name: 'Person'
  belongs_to :person_report, class_name: 'Person'

  after_create :mark_count

  def mark_count
    person_marked.infected! if quantity_marks > 2
  end

  def quantity_marks
    MarkSurvivor.where(person_marked: person_marked.id).count
  end
end
