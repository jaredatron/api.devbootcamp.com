ApiDevbootcampCom::Application.routes.draw do

  namespace :v1 do

    resources :users do
      resources :challenge_attempts
    end

    resources :cohorts

    resources :challenges

    resources :challenge_attempts

  end

end