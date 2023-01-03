# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Person' do
  let(:headers) { { 'Content-Type': 'application/json' } }
  let(:json) { JSON.parse(response.body, symbolize_names: true) }
  let(:invalid_attributes) do
    {
      status: 'bridge',
      latitude: Faker::Address.latitude
    }
  end

  let(:params) do
    {
      name: 'Sam',
      gender: 'male',
      latitude: Faker::Address.latitude,
      longitude: Faker::Address.longitude
    }
  end

  describe 'POST /create' do
    describe '#validations' do
      context 'when send params' do
        it 'creates a new Person' do
          expect do
            post people_url, params: { person: params }
          end.to change(Person, :count).by(1)
        end

        it 'return person created' do
          post people_url, params: { person: params }
          expect(response).to have_http_status(:created)
        end
      end
    end
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Person.create! params
      get people_url
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /closest' do
    before do
      create_list(:person, 5)
      get(closest_person_path(Person.first))
    end

    it 'renders a successful response' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /infected' do
    let!(:survivor) { create(:person) }
    let!(:last_person) { create(:person) }

    context 'when a person report another is infected' do
      before do
        create_list(:person, 5)
      end

      it 'must create a marksurvivor', :aggregate_failures do
        expect { post(infected_person_survivor_path(survivor, Person.second)) }
          .to change(MarkSurvivor, :count).by(1)
      end
    end

    context 'when the person is marked 3 times' do
      let(:mark_survivor) { create(:mark_survivor, person_marked: survivor) }
      let(:mark_survivor2) { create(:mark_survivor, person_marked: survivor) }

      before do
        mark_survivor
        mark_survivor2
        post(infected_person_survivor_path(last_person, survivor))
      end

      it 'must update status to infected from person', :aggregate_failures do
        expect(response).to have_http_status(:ok)
        expect { survivor.reload }
          .to change(survivor, :status).from('survivor').to('infected')
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        {
          name: 'fulano'
        }
      end

      it 'updates the requested person' do
        person = Person.create! params
        patch person_url(person), params: { person: new_attributes }
        person.reload
        expect(person.name).to eq('fulano')
      end

      it 'redirects to the person' do
        person = Person.create! params
        patch person_url(person), params: { person: new_attributes }
        person.reload
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested person' do
      person = Person.create! params
      expect do
        delete person_url(person)
      end.to change(Person, :count).by(-1)
    end

    it 'redirects to the peoples list' do
      person = Person.create! params
      delete person_url(person)
      expect(response).to have_http_status(:ok)
    end
  end
end
