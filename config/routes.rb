Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  namespace 'api' do
    namespace 'v1' do
      get '/subjects', to: 'subjects#index', as: :subjects
      get '/subjects/:id', to: 'subjects#show', as: :subject
      post 'subjects', to: 'subjects#create', as: :create_subject
    end
  end
end
