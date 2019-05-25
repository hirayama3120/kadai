module Swagger::UserSchema
  extend ActiveSupport::Concern
  include Swagger::Blocks

  included do
    swagger_schema :User do
      key :required, [:FirstName, :LastName, :MailAddress]
      property :FirstName do
        key :type, :string
      end
      property :LastName do
        key :type, :string
      end
      property :MailAddress do
        key :type, :string
      end
    end
  end
end