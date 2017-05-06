module Serializer
  extend ActiveSupport::Concern

  def serialize(object, serializer)
    if object[:result]
      if object.respond_to?(:to_a?)
        render json: object, each_serializer: serializer
      else
        render json: object, serializer: serializer
      end
    else
      render json: { errors: object[:errors].as_json }
    end
  end
end
