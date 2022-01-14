class Hospital < ApplicationRecord
  has_many :doctors
  has_many :patients, through: :doctors

  def doctor_count
    doctors.count
  end

  def doctor_universities
    doctors.distinct(:university).pluck(:university).join(', ')
  end
end
