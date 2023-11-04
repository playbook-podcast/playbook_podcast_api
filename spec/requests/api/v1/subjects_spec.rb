require 'swagger_helper'

RSpec.describe 'api/v1/subjects', type: :request do
  path '/api/v1/subjects' do
    get 'subjects list' do
      tags 'Subjects'

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

      response 204, 'No subjects' do
        run_test!
      end
    end
  end

  path '/api/v1/subjects/{id}' do
    parameter name: 'id', in: :path, type: :integer, required: true, description: 'Subject ID'

    get 'show a subject' do
      tags 'Subjects'

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

  path '/api/v1/subjects' do
    post 'create a subject' do
      tags 'Subjects'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :subject, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string, description: 'Subject title' },
          body: { type: :string, description: 'Subject body' },
        },
        required: %w[title body]
      }

      response '201', 'Subject created' do
        run_test!
      end

      response '400', 'Bad Request' do
        run_test!
      end

      response '422', 'Invalid request' do
        run_test!
      end
    end
  end
end
