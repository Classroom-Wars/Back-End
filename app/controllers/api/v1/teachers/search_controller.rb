module Api
  module V1
    module Teachers
      class SearchController < ApplicationController
        def show
          exist = Course.find_by(course_code: course_params[:coursecode])
          render json: CourseSerializer.new(exist)
        end

        private

        def course_params
          params.permit(:coursecode)
        end
      end
    end
  end
end
