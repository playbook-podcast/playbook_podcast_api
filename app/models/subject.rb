class Subject < ApplicationRecord
  has_one_attached :body_audio
  has_one_attached :intro_audio
  has_one_attached :summary_audio

  validates :title, :body, presence: true

  def estimate_reading_time
    body.reading_time(format: :approx)
  end

  def audio_duration
    if body_audio.attached?
      file_path = ActiveStorage::Blob.service.send(:path_for, body_audio.key)

      Mp3Info.open(file_path) do |mp3info|
        return mp3info.length.to_i
      end
    else
      0
    end
  rescue Mp3InfoError
    0
  end
end
