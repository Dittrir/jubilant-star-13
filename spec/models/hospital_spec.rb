require 'rails_helper'

RSpec.describe Hospital do
  describe 'relationships' do
    it { should have_many(:doctors) }
    it { should have_many(:patients).through(:doctors) }
  end
  describe 'methods' do
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

    it '#doctor_count' do
      expect(@hospital_1.doctor_count).to eq(4)
    end

    it '#doctor_universities' do
      expect(@hospital_1.doctor_universities).to eq("CWU, WWU, Yale")
    end
  end
end
