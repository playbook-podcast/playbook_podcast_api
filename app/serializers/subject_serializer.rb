class SubjectSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :summary
end
