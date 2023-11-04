Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  namespace 'api' do
    namespace 'v1' do
      get '/subjects/:id', to: 'subjects#show', as: :subject
    end
  end
end
