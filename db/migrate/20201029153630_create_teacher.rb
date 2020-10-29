# frozen_string_literal: true

class CreateTeacher < ActiveRecord::Migration[5.2]
  def change
    create_table :teachers do |t|
      t.string :name
    end
  end
end
