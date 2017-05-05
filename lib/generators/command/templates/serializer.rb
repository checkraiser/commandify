module Serializer
  extend ActiveSupport::Concern

  def serialize(object, options = nil)
    if options.present?
      render json: object.as_json_with_includes(options)
    else
      render json: object
    end
  end
end
