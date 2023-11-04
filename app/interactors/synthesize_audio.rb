# frozen_string_literal: true

class SynthesizeAudioContext < ActiveInteractor::Context::Base
  attributes :text, :audio

  validates :text, presence: true, on: :calling
end

class SynthesizeAudio < ActiveInteractor::Base
  def perform
    context.audio = GoogleTextToSpeechService.new(context.text).synthesize_speech
  end
end
