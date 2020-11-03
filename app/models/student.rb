# frozen_string_literal: true

class Student < ApplicationRecord
  has_many :course_students, dependent: :destroy
  has_many :courses, through: :course_students

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates :provider, presence: true
  validates :uid, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :token, presence: true
  validates :refresh_token, presence: true

  def self.update_or_create(auth)
    student = Student.find_by(uid: auth[:uid]) || Student.new

    student.attributes = {
      provider: auth[:provider],
      uid: auth[:uid],
      email: auth[:info][:email],
      first_name: auth[:info][:first_name],
      last_name: auth[:info][:last_name],
      token: auth[:credentials][:token],
      refresh_token: auth[:credentials][:refresh_token]
      }

    student.save

    student
  end
end
