class LegalPeopleController < ApplicationController
  
  before_action :set_legal_person, except: [:create]


  def create
    @legal_person = LegalPerson.create(legal_person_params)
  end

  def update
    @legal_person = LegalPerson.update(legal_person_params)
  end

  def destroy
    @legal_person.destroy
  end

  private

  def set_legal_person
    @legal_person = LegalPerson.find(params[:legal_person_id])
  end

  def legal_person_params
    params.require(:legal_person).permit(:social_insurance_number, :full_name, :birth_date)
  end
end
