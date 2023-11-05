# frozen_string_literal: true

class SynthesizeAudioContext < ActiveInteractor::Context::Base
  attributes :text, :audio, :audio_type, :filename

  validates :text, presence: true, on: :calling
  validates :filename, presence: true, if: -> { long_text? }

  def long_text?
    text.length > 500
  end
end

class SynthesizeAudio < ActiveInteractor::Base
  def perform
    tts_service = GoogleTextToSpeechService.new(context.text)
    context.audio = if context.long_text?
                      context.audio_type = 'wav'
                      tts_service.synthesize_speech_long(context.filename)
                    else
                      context.audio_type = 'mp3'
                      tts_service.synthesize_speech
                    end
  end
end
