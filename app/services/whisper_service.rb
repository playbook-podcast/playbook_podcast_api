# frozen_string_literal: true

class WhisperService
  def transcribe(file)
    return unless file

    response = client.audio.transcribe(
      parameters: {
        model: 'whisper-1',
        file: file
      }
    )

    handle_response(response)
  rescue OpenAI::Error => e
    handle_error(e)
  end

  private

  def handle_response(response)
    response.fetch("text", "")
  end

  def handle_error(error)
    Rails.logger.error("WhisperService Error: #{error.message}")
    nil
  end

  def client
    @client ||= OpenAI::Client.new
  end
end
