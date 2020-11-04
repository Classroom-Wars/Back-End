# frozen_string_literal: true

class Teacher < ApplicationRecord
  has_many :courses, dependent: :destroy

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates :provider, presence: true
  validates :uid, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :token, presence: true

    def self.update_or_create(auth)
      teacher = Teacher.find_by(uid: auth[:uid]) || Teacher.new
      teacher.attributes = {
        provider: auth[:user_data][:provider],
        uid: auth[:user_data][:uid],
        email: auth[:user_data][:info][:email],
        first_name: auth[:user_data][:info][:first_name],
        last_name: auth[:user_data][:info][:last_name],
        token: auth[:user_data][:credentials][:token]
        }

      teacher.save
      teacher
    end
end
