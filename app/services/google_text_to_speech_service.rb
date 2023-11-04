# frozen_string_literal: true

class GoogleTextToSpeechService
  attr_reader :text

  DEFAULT_VOICE_NAME = 'en-US-Studio-M'
  DEFAULT_LANGUAGE_CODE = 'en-US'
  DEFAULT_AUDIO_ENCODING = 'MP3'

  def initialize(text)
    @client = Google::Cloud::TextToSpeech.text_to_speech
    @text = text
  end

  def synthesize_speech(
    name: DEFAULT_VOICE_NAME,
    language_code: DEFAULT_LANGUAGE_CODE,
    audio_encoding: DEFAULT_AUDIO_ENCODING
  )
    response = client.synthesize_speech(
      input: { text: },
      voice: { name:, language_code: },
      audio_config: { audio_encoding: }
    )

    response.audio_content
  end


  private

  def client
    @client ||= Google::Cloud::TextToSpeech.text_to_speech
  end
end
