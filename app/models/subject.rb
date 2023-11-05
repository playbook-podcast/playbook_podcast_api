require 'streamio-ffmpeg'

class Subject < ApplicationRecord
  include Rails.application.routes.url_helpers

  has_one_attached :body_audio
  has_one_attached :intro_audio
  has_one_attached :summary_audio

  validates :title, :body, presence: true

  def estimate_reading_time
    body.reading_time(format: :approx)
  end

  def audio_duration
    if body_audio.attached?
      file_path = "tmp/audio/#{body_audio.filename}"

      File.open(file_path, 'wb') do |file|
        file.write(body_audio.download)
      end

      audio = FFMPEG::Movie.new(file_path)

      duration =
        case audio.duration.to_i
        when 0
          '0 seconds'
        when 1...60
          "#{audio.duration.to_i} seconds"
        else
          "#{audio.duration.to_i / 60} minutes"
        end

      return duration
    else
      '0 seconds'
    end
  rescue FFMPEG::Error
    '0 seconds'
  end
end
