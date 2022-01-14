require 'rails_helper'

RSpec.describe 'Doctor Show Page' do
  describe 'view' do
    before(:each) do
      @hospital_1 = Hospital.create!(name: "Grey Sloan Memorial Hospital")

      @doctor_1 = @hospital_1.doctors.create!(name: "Dr. X", specialty: "X-men Repair", university: "Yale")

      @patient_1 = Patient.create!(name: "Kayla", age: "34")
      @patient_2 = Patient.create!(name: "Fred", age: "30")
      @patient_3 = Patient.create!(name: "Marc", age: "50")

      @patient_1.doctor_patients.create!(doctor_id: @doctor_1.id)
      @patient_2.doctor_patients.create!(doctor_id: @doctor_1.id)
      @patient_3.doctor_patients.create!(doctor_id: @doctor_1.id)
    end

    it 'shows doctors name, specialty, and university' do
      visit "/doctors/#{@doctor_1.id}"

      expect(page).to have_content(@doctor_1.name)
      expect(page).to have_content(@doctor_1.specialty)
      expect(page).to have_content(@doctor_1.university)
    end

    it 'shows doctors hospital name and doctors patients names' do
      visit "/doctors/#{@doctor_1.id}"

      expect(page).to have_content(@hospital_1.name)
      expect(page).to have_content(@patient_1.name)
      expect(page).to have_content(@patient_2.name)
      expect(page).to have_content(@patient_3.name)
    end

    it 'has a button to remove patient from doctor caseload' do
      visit "/doctors/#{@doctor_1.id}"

      expect(page).to have_content(@patient_1.name)

      click_button "Remove #{@patient_1.name} From Caseload"
      expect(current_path).to eq("/doctors/#{@doctor_1.id}")

      expect(page).to_not have_content(@patient_1.name)
    end

    it 'REFACTOR: Tests accurate SQL in doctor_patients destroy action by adding other doctors' do #test could have failed by grabbing another doctors same patient.
      doctor_2 = @hospital_1.doctors.create!(name: "Other Doctor", specialty: "Lung Surgeon", university: "UCLA")
      @patient_1.doctor_patients.create!(doctor_id: doctor_2.id)

      doctor_3 = @hospital_1.doctors.create!(name: "Different Doctor", specialty: "Heart Surgeon", university: "OSU")
      @patient_1.doctor_patients.create!(doctor_id: doctor_3.id)

      visit "/doctors/#{@doctor_1.id}"

      expect(page).to have_content(@patient_1.name)

      click_button "Remove #{@patient_1.name} From Caseload"
      expect(current_path).to eq("/doctors/#{@doctor_1.id}")

      expect(page).to_not have_content(@patient_1.name)
      expect(page).to have_content(@patient_2.name)
      expect(page).to have_content(@patient_3.name)
    end
  end
end
