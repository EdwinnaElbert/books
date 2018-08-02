# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.swagger_root = Rails.root.to_s + '/swagger'

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:to_swagger' rake task, the complete Swagger will
  # be generated at the provided relative path under swagger_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a swagger_doc tag to the
  # the root example_group in your specs, e.g. describe '...', swagger_doc: 'v2/swagger.json'
  config.swagger_docs = {
    'swagger.json' => {
      swagger: '2.0',
      info: {
        title: 'Books',
        description: '',
        version: '1.0',
        contact: {
          name: 'Support',
          email: 'nalcarya1881@gmail.com'
        }
      },
      tags: [
        {
          name: 'Shops',
          description: 'Get all books in shops of a specific publisher'
        }
      ],
      basePath: '/',
      consumes: 'application/json',
      produces: 'application/json',

      definitions: {
        DefaultSuccessResponse: {
          required: [:success],
          type: :object,
          properties: {
            success: { type: :boolean, default: true }
          }
        },
        DefaultErrorResponse: {
          required: [:errors],
          type: :object,
          properties: {
            errors: {
              type: :array,
              items: {
                required: [:id, :code, :title],
                type: :object,
                properties: {
                  id: { type: :integer },
                  code: { type: :integer, format: :int32 },
                  title: { type: :string }
                }
              }
            }
          }
        },
        CategoryObject: {
          required: [:id],
          type: :object,
          properties: {
            id: { type: :string },
            children: {
              type: :array,
              items: {
                schema: {
                  '$ref' => '#/definitions/CategoryObject'
                }
              }
            }
          }
        },
        TagObject: {
          required: [:id],
          type: :object,
          properties: {
            id: { type: :string }
          }
        }
      }
    }
  }
end
