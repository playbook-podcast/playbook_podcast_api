class SubjectSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :title, :body, :summary, :body_audio_url

  def body_audio_url
    rails_blob_url(object.body_audio, only_path: true) if object.body_audio.attached?
  end
end
