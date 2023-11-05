class SubjectsSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :summary, :body_estimate_reading_time, :body_audio_duration

  def body_estimate_reading_time
    object.estimate_reading_time
  end

  def body_audio_duration
    object.audio_duration
  end
end
