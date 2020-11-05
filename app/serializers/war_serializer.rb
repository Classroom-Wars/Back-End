class WarSerializer < BaseSerializer
  attributes :challenger_course_id, :opponent_course_id, :challenger_course_points, :opponent_course_points, :teacher_id
  belongs_to :teacher
end
