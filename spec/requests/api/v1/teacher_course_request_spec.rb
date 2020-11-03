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
    teacher2.courses.create({
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

  it 'can create a course' do
    teacher = create(:teacher)
    course_params = ({
      name: 'Bull Riding',
      school_name: 'Waylon Academy',
      teacher_id: teacher.id
    })

    post "/api/v1/teachers/courses", params: course_params
    expect(response).to be_successful

    course = JSON.parse(response.body, symbolize_names: true)

    expect(course[:data][:attributes][:name]).to eq(course_params[:name])
    expect(course[:data][:attributes][:school_name]).to eq(course_params[:school_name])
    expect(course[:data][:attributes][:teacher_id]).to eq(course_params[:teacher_id])

  end

  it 'can destroy a course' do
    teacher = create(:teacher)
    course = teacher.courses.create({
      name: 'Bull Riding',
      school_name: 'Waylon Academy'
    })

    expect(Course.count).to eq(1)
    delete "/api/v1/teachers/courses/#{course.id}"
    expect(response).to be_successful
    expect(Course.count).to eq(0)

    expect{Course.find(course.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

  it 'can update a course' do
    teacher = create(:teacher)

    course1 = create(:course, teacher_id: teacher.id)
    update_params = ({
      name: "I am updated!",
      course_id: course1.id
    })
    course2 = create(:course, teacher_id: teacher.id)

    patch "/api/v1/teachers/courses/#{course1.id}", params: update_params
    expect(response).to be_successful

    update_course = JSON.parse(response.body, symbolize_names: true)
    expect(update_course[:data][:attributes][:name]).to_not eq(course1.name)
    expect(update_course[:data][:attributes][:name]).to eq(update_params[:name])
    expect(update_course[:data][:attributes][:name]).to_not eq(course2.name)
  end
end
