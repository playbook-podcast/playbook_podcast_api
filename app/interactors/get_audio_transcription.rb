# frozen_string_literal: true

class GetAudioTranscriptionContext < ActiveInteractor::Context::Base
  attributes :audio_blob, :transcription

  validates :audio_blob, presence: true, on: :calling
end

class GetAudioTranscription < ActiveInteractor::Base
  def perform
    service = WhisperService.new
    context.transcription = service.transcript_audio(context.audio_blob)
  end
end
