class SubjectsSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :summary
end
