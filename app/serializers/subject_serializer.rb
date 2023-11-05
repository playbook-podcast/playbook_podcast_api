class SubjectSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :title, :body, :summary, :body_audio_url, :estimate_reading_time, :body_audio_duration

  def body_audio_url
    rails_blob_url(object.body_audio, only_path: true) if object.body_audio.attached?
  end

  def body_estimate_reading_time
    object.estimate_reading_time
  end

  def body_audio_duration
    object.audio_duration
  end
end
