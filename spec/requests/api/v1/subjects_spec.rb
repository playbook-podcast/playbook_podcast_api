require 'swagger_helper'

RSpec.describe 'api/v1/subjects', type: :request do
  path '/api/v1/subjects/{id}' do
    parameter name: 'id', in: :path, type: :integer, required: true, description: 'Subject ID'

    get 'show subject' do
      response 200, 'Successful' do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response 404, 'Subject not found' do
        run_test!
      end
    end
  end
end
