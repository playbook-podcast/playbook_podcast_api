class SubjectSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :title, :introduction, :summary, :body, :estimate_reading_time, :body_audio_duration

  def introduction
    {
      audio_url: intro_audio_url,
      text: object.intro,
      transcription: object.intro_transcription,
    }
  end

  def summary
    {
      audio_url: summary_audio_url,
      text: object.summary,
      transcription: object.summary_transcription,
    }
  end

  def body
    {
      audio_url: body_audio_url,
      text: object.body,
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

  def intro_audio_url
    rails_blob_url(object.intro_audio, only_path: true) if object.intro_audio.attached?
  end
end
