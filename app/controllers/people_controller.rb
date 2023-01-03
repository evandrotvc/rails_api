# frozen_string_literal: true

class PeopleController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_person,
    only: %i[show edit update destroy closest]

  def index
    @people = Person.all
    render status: :ok, json: @people
  end

  def show
    render status: :ok, json: @person
  end

  def new
    @person = Person.new
  end

  def edit; end

  def closest
    @person_closest, @distance = @person.closest_person

    render status: :ok, json: { person: @person_closest, distance: @distance }
  end

  def infected
    @person_report = Person.find(params[:person_id])
    @person_marked = Person.find(params[:person_target_id])

    mark = @person_report.create_mark_survivor(@person_marked)

    if mark
      render status: :ok,
        json: { message: "#{@person_marked.name} marked with sucess." }
    end
  rescue ActiveRecord::RecordNotUnique
    render status: :unprocessable_entity,
      json: { message: "Error: #{@person_marked.name} already was marked for you" }
  end

  def create
    @person = Person.new(person_params)

    if @person.save
      render json: @person, status: :created
    else
      render json: @person.errors, status: :unprocessable_entity
    end
  end

  def update
    if @person.update(person_params)
      render json: @person, status: :ok
    else
      render json: @person.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @person.destroy

    render status: :ok, json: { message: 'Person was destroyed with sucess' }
  end

  private

  def set_person
    @person = Person.find(params[:id])
  end

  def person_params
    params.require(:person).permit(:name, :gender, :latitude, :longitude)
  end
end
