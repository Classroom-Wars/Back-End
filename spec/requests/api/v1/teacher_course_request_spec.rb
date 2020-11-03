# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'teachers courses' do
  it 'can see a dashboard (courses index)' do
    teacher1 = create(:teacher)
    course1 = teacher1.courses.create({
      name: 'Principles of Real Estate',
      course_code: 'abcd1234',
      school_name: 'Hogwarts High School',
      teacher_id: teacher1.id,
      course_points: 0
    })
    course2 = teacher1.courses.create({
      name: 'Forensic Psychology',
      course_code: '1234abcd',
      school_name: 'Hogwarts High School',
      teacher_id: teacher1.id,
      course_points: 0
    })
    teacher2 = create(:teacher)
    not_enrolled_course = teacher2.courses.create({
      name: 'You Shouldnt See Me',
      course_code: '1a2b3c4d',
      school_name: 'Hogwarts High School',
      teacher_id: teacher2.id,
      course_points: 0
    })
    teacher_course_params = ({teacher_id: teacher1.id})
    get "/api/v1/teachers/courses", params: teacher_course_params
    expect(response).to be_successful
    returned_courses = JSON.parse(response.body, symbolize_names: true)
    expect(returned_courses[:data][0][:id].to_i).to eq(course1.id)
    expect(returned_courses[:data][0][:attributes][:name]).to eq(course1[:name])
    expect(returned_courses[:data][1][:id].to_i).to eq(course2.id)
    expect(returned_courses[:data][1][:attributes][:name]).to eq(course2[:name])
    expect(returned_courses[:data].count).to eq(2)
  end
  # it 'updates a course' do
  #   teacher = create(:teacher)
  #
  #   course = create(:course, teacher_id: teacher.id)
  #
  #   patch "/api/v1/teachers/courses/#{course.id}"
  #
  #   expect(response).to be_successful
  #
  #   course = JSON.parse(response.body, symbolize_names: true)
  #   # expect(response).to be_successful
  #   #
  #   # expect(students).to have_key(:data)
  #   # expect(students[:data]).to be_an(Array)
  #   # expect(students[:data].count).to eq(3)
  #
  #
  # end
  #
  # it 'creates a new course' do
  #   teacher = create(:teacher)
  #   course_params = ({
  #     name: 'Principals of Real Estate',
  #     course_code: 'abcd1234',
  #     school_name: 'Hogwarts High School',
  #     teacher_id: teacher.id
  #   })
  #
  #   post "/api/v1/teachers/courses", params: course_params
  #   expect(response).to be_successful
  #
  #   course = JSON.parse(response.body, symbolize_names: true)
  #
  #
  # end
end
