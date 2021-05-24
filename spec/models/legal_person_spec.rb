require 'rails_helper'

RSpec.describe LegalPerson, type: :model do
  context 'validation tests' do
    it 'ensures federal business number presence' do
      legal_person = LegalPerson.new(company_name: 'company name', fantasy_name: 'fantasy name').save
      expect(legal_person).to eq(false)
    end
    it 'ensures company name presence' do
      legal_person = LegalPerson.new(federal_business_number: 123456789, fantasy_name: 'fantasy name').save
      expect(legal_person).to eq(false)
    end
    it 'ensures fantasy name presence' do
      legal_person = LegalPerson.new(federal_business_number: 123456789, company_name: 'company name').save
      expect(legal_person).to eq(false)
    end

    it 'ensures federal business number to be 9 digits' do
      legal_person_1 = LegalPerson.new(federal_business_number: 12345678, company_name: 'company name', fantasy_name: 'fantasy name').save
      expect(legal_person_1).to eq(false)
      legal_person_2 = LegalPerson.new(federal_business_number: 1234567890, company_name: 'company name', fantasy_name: 'fantasy name').save
      expect(legal_person_2).to eq(false)

    end

    it 'should save succesfully with valid params' do
      legal_person = LegalPerson.new(federal_business_number: 123456789, company_name: 'company name', fantasy_name: 'fantasy name').save
      expect(legal_person).to eq(true)
    end
  end
end
