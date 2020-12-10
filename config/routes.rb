# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      namespace :teachers do
        get '/courses/find', to: 'search#show'
        get '/courses/wars', :action => 'my_wars'
        post '/courses/wars', :action => 'create_war'
        delete '/courses/wars/:id', :action => 'destroy_war'
        post '/courses/prizes', to: 'prizes#create'
        get '/courses/all-prizes', to: 'prizes#index'
        delete '/courses/prizes', to: 'prizes#destroy'
        get '/courses/students', :action => 'students_by_course'
        resources :courses do
        end
      end

      namespace :students do
        get '/courses/all-points', to: 'courses#all_points'
        get '/courses/points', to: 'courses#points'
        resources :courses
      end
      resources :students, :teachers
      get '/pom/single_trivia_question', to: 'poms#single_trivia_question'

      get '/students/find/:uid', to: 'students#find'
      get '/teachers/find/:uid', to: 'teachers#find'
    end
  end
end
