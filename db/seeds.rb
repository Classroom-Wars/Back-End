# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Course.destroy_all
CourseStudent.destroy_all
Student.destroy_all
Teacher.destroy_all
Pom.destroy_all

class Seed
  def self.start
    seed = Seed.new
    seed.seed_students_teachers_courses
    seed.no_connect_courses
    ActiveRecord::Base.connection.tables.each do |t|
      ActiveRecord::Base.connection.reset_pk_sequence!(t)
    end
  end

  def seed_students_teachers_courses
    20.times do |i|
      Student.create!(name: Faker::Name.name )
    end
    10.times do |i|
      teacher = Teacher.create!(name: Faker::Name.name)
      2.times do |i|
        course = teacher.courses.create!(
          name: Faker::Educator.subject,
          course_code: Faker::Alphanumeric.alphanumeric(number: 8),
          school_name: Faker::Educator.university,
          course_points: Faker::Number.within(range: 0..100000)
        )
        rand(1..3).times do
          CourseStudent.create!(course_id: course.id, student_id: Student.ids.sample, student_points: Faker::Number.within(range: 0..1000))
        end
      end
    end
  end

    #sad path seeds (teachers with courses and no connections to students)
  def no_connect_courses
    2.times do |i|
      teacher = Teacher.create!(name: Faker::Name.name)
      2.times do |i|
        course = teacher.courses.create!(
          name: Faker::Educator.subject,
          course_code: Faker::Alphanumeric.alphanumeric(number: 8),
          school_name: Faker::Educator.university,
          course_points: Faker::Number.within(range: 0..100000)
        )
      end
    end
  end
end
Seed.start
