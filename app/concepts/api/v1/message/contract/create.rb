require 'reform'
require 'reform/form/dry'
require 'dry-validation'

module Message::Contract
  class Create < Reform::Form
    include Dry

    property :text
    property :to_user_id

    validation :default, with: { form: true } do
      configure do
        def user_exists?(value)
          User.exists?(id: value)
        end
      end

      required(:text).filled
      required(:to_user_id).filled(:user_exists?)
    end
  end
end
