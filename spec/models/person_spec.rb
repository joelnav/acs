require 'rails_helper'

RSpec.describe Person, type: :model do
  context 'validation tests' do
    it 'ensures social insurance number presence' do
      person = Person.new(full_name: 'full name', birth_date: Date.today).save
      expect(person).to eq(false)
    end
    it 'ensures full name presence' do
      person = Person.new(social_insurance_number: 123456789, birth_date: Date.today).save
      expect(person).to eq(false)
    end
    it 'ensures birth date presence' do
      person = Person.new(social_insurance_number: 123456789, full_name: 'full name').save
      expect(person).to eq(false)
    end

    it 'ensures social insurance number to be 9 digits' do
      person_1 = Person.new(social_insurance_number: 12345678, full_name: 'full name', birth_date: Date.today).save
      expect(person_1).to eq(false)
      person_2 = Person.new(social_insurance_number: 1234567890, full_name: 'full name', birth_date: Date.today).save
      expect(person_2).to eq(false)

    end

    it 'should save succesfully with valid params' do
      person = Person.new(social_insurance_number: 123456789, full_name: 'full name', birth_date: Date.today).save
      expect(person).to eq(true)
    end

    
  end
end
