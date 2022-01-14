require 'rails_helper'

RSpec.describe 'Hospital Show Page' do
  describe 'view' do
    before(:each) do
      @hospital_1 = Hospital.create!(name: "Grey Sloan Memorial Hospital")

      @doctor_1 = @hospital_1.doctors.create!(name: "Dr. X", specialty: "X-men Repair", university: "Yale")
      @doctor_2 = @hospital_1.doctors.create!(name: "Dr. Joe", specialty: "Sleep research", university: "WWU")
      @doctor_3 = @hospital_1.doctors.create!(name: "Dr. Sally", specialty: "Super power therapy", university: "CWU")
      @doctor_4 = @hospital_1.doctors.create!(name: "Dr. Y", specialty: "Eye doctor", university: "Yale")

      @patient_1 = Patient.create!(name: "Kayla", age: "34")
      @patient_2 = Patient.create!(name: "Fred", age: "30")
      @patient_3 = Patient.create!(name: "Marc", age: "50")

      @patient_1.doctor_patients.create!(doctor_id: @doctor_1.id)
      @patient_2.doctor_patients.create!(doctor_id: @doctor_1.id)
      @patient_3.doctor_patients.create!(doctor_id: @doctor_1.id)
    end

    it 'shows hospital name and number of doctors that work there' do
      visit "hospitals/#{@hospital_1.id}"

      expect(page).to have_content(@hospital_1.name)
      expect(page).to have_content("Number of doctors that work at this hospital: 4")
    end

    it 'shows unique list of universities that this hospitals doctors attended' do
      visit "hospitals/#{@hospital_1.id}"

      expect(page).to have_content("Universitys that these doctors attended: CWU, WWU, Yale")
    end
  end
end
