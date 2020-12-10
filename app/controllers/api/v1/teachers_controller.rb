module Api
  module V1
    class TeachersController < ApplicationController
      def index
        render json: TeacherSerializer.new(Teacher.all)
      end

      def show
        render json: TeacherSerializer.new(Teacher.find(params[:id]))
      end

      def create
        teacher_params = JSON.parse(request.body.read, symbolize_names: true)
        teacher = Teacher.update_or_create(teacher_params)
        render json: TeacherSerializer.new(teacher)
      end

      def update
        teacher_params = JSON.parse(request.body.read, symbolize_names: true)
        render json: TeacherSerializer.new(Teacher.update(params[:id], teacher_params))
      end

      def destroy
        Teacher.destroy(params[:id])
        render body: nil, status: :no_content
      end

      def find
        render json: TeacherSerializer.new(Teacher.find_by(uid: params[:uid]))
      end

      def my_wars
        teacher = Teacher.find(war_params[:teacher_id])
        render json: WarSerializer.new(teacher.wars)
      end

      def create_war
        war = War.create(war_params)
        render json: WarSerializer.new(war)
      end

      def destroy_war
        War.destroy(params[:id])
        render body: nil, status: :no_content
      end

      def students_by_course
        course = Course.find(params[:course_id])
        render json: StudentSerializer.new(course.students)
      end

      private

      def teacher_params
        params.permit(:first_name, :last_name, :provider, :uid, :email, :token, :refresh_token, :school_name, :school_district)
      end

      def war_params
        params.permit(:teacher_id, :challenger_course_id, :opponent_course_id, :challenger_course_points, :opponent_course_points, :opponent_course_name)
      end

      def student_params
        params.permit(:course_id)
      end
    end
  end
end
