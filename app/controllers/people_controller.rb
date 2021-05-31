class PeopleController < ApplicationController
  
  before_action :set_person, except: [:create]


  def create
    @person = Person.create(person_params)
  end

  def update
    @person = Person.update(person_params)
  end

  def destroy
    @person.destroy
  end

  private

  def set_person
    @person = Person.find(params[:person_id])
  end

  def person_params
    params.require(:person).permit(:social_insurance_number, :full_name, :birth_date)
  end
end
