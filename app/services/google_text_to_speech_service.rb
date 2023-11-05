# frozen_string_literal: true
require 'google/cloud/storage'

class GoogleTextToSpeechService
  DEFAULT_VOICE_NAME = 'en-US-Studio-M'
  DEFAULT_LANGUAGE_CODE = 'en-US'
  DEFAULT_AUDIO_ENCODING = 'MP3'
  GCS_BUCKET_NAME = 'playbook-poscast-audiobucket'
  GCS_PATH_PREFIX = "audio/"

  attr_reader :text

  def initialize(text)
    @text = text
  end

  def synthesize_speech(
    name: DEFAULT_VOICE_NAME,
    language_code: DEFAULT_LANGUAGE_CODE,
    audio_encoding: DEFAULT_AUDIO_ENCODING
  )
    response = tts_client.synthesize_speech(
      input: { text: text },
      voice: { name: name, language_code: language_code },
      audio_config: { audio_encoding: audio_encoding }
    )

    response.audio_content
  end

  def synthesize_speech_long(
    filename,
    name: DEFAULT_VOICE_NAME,
    language_code: DEFAULT_LANGUAGE_CODE,
    audio_encoding: DEFAULT_AUDIO_ENCODING
    )
    operation = long_audio_client.synthesize_long_audio(
      parent: "projects/1040711569792/locations/us-central1",
      input: { text: text },
      voice: { name:, language_code: },
      audio_config: { audio_encoding: 'LINEAR16' },
      output_gcs_uri: "gs://#{GCS_BUCKET_NAME}/#{GCS_PATH_PREFIX}#{filename}.wav"
    )

    return unless ensure_operation_successful(operation)

    file = download_audio_from_gcs(filename)
    File.binread(file)
  end

  private

  def tts_client
    @tts_client ||= Google::Cloud::TextToSpeech.text_to_speech
  end

  def long_audio_client
    @long_audio_client ||= Google::Cloud::TextToSpeech.text_to_speech_long_audio_synthesize
  end

  def ensure_operation_successful(operation)
    operation.wait_until_done!

    if operation.error?
      puts "Error during operation: #{operation.error.message}"
      false
    else
      true
    end
  end

  def download_audio_from_gcs(filename)
    storage = Google::Cloud::Storage.new
    bucket = storage.bucket GCS_BUCKET_NAME
    blob = bucket.file "#{GCS_PATH_PREFIX}#{filename}.wav"
    blob.download "#{filename}.wav"
  end
end
