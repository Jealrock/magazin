module Api::V1::Category
  class Index < ApplicationOperation
    step :model!

    def model!(options, *)
      options['model'] = Category.all
    end
  end
end
