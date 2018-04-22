class Api::V1::UrlsSerializer < ActiveModel::Serializer
  attributes(*Url.attribute_names.map(&:to_sym))
end
