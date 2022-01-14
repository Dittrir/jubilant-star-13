class DoctorPatientsController < ApplicationController
  def destroy
    doctor = Doctor.find(params[:doctor_id])
    patient = Patient.find(params[:id]) #Scrapped use of find_by
    doctor.patients.destroy(patient)

    redirect_to "/doctors/#{doctor.id}"
  end
end
