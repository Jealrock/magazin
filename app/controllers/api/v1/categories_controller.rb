module Api::V1
  class CategoriesController < ApiController
    def index
      run Category::Index
      result_index(result, serializer: ::Api::V1::CategorySerializer)
    end
  end
end
