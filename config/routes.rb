Rails.application.routes.draw do
  #get 'quiz_submissions/create'
  #get 'quiz_submissions/show'
  devise_for :users
  
  resources :quizzes do 
    resources :questions, only: [:new, :create, :index, :show] do
     resources :submissions, only: [:create, :show], controller: 'quiz_submissions'
    end
  end

  resources :quizzes, only: [:new, :create, :index, :show]
  root 'quizzes#index'
end
