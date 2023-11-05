class SubjectSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :title, :summary, :body, :estimate_reading_time, :body_audio_duration

  def summary
    {
      audio_url: summary_audio_url,
      transcription: object.summary_transcription,
    }
  end

  def body
    {
      audio_url: body_audio_url,
      transcription: object.body_transcription,
    }
  end

  def body_audio_url
    rails_blob_url(object.body_audio, only_path: true) if object.body_audio.attached?
  end

  def body_estimate_reading_time
    object.estimate_reading_time
  end

  def body_audio_duration
    object.audio_duration
  end

  def summary_audio_url
    rails_blob_url(object.summary_audio, only_path: true) if object.summary_audio.attached?
  end
end
