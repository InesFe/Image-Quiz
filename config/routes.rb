Rails.application.routes.draw do
  devise_for :users

  resources :quizzes do 
    post :submit_quiz, on: :member, to: 'quiz_submissions#submit_quiz'
    resources :questions, only: [:new, :create, :index, :show] do
      resources :submissions, only: [:create, :show], controller: 'quiz_submissions'
    end
  end

  root 'quizzes#index'
end