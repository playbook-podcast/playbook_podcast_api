# frozen_string_literal: true
class OpenAiError < StandardError; end

class WhisperService
  CHUNK_SIZE = 24 * 1024 * 1024 # 24MB
  SUPPORTED_FORMATS = %w[flac m4a mp3 mp4 mpeg mpga oga ogg wav webm].freeze
  MAX_RETRIES = 3
  WAIT_DURATION = 5 # seconds

  def transcript_audio(blob)
    blob.open do |file|
      format = File.extname(file.path).sub('.', '')
      file_size = file.size

      return [audio_to_text(file, format)] if file_size <= CHUNK_SIZE

      process_chunks(file, file_size, format)
    end
  end

  private

  def process_chunks(file, file_size, format)
    chunks = (file_size.to_f / CHUNK_SIZE).ceil
    (0...chunks).map do |i|
      chunk = extract_chunk(file, i, CHUNK_SIZE, file_size)
      read_response(audio_to_text(chunk, format))
    end
  end

  def extract_chunk(file, index, chunk_size, file_size)
    offset = index * chunk_size
    length = [chunk_size, file_size - offset].min

    chunk_file = Tempfile.new(['audio', "-#{index}.chunk"], unlink: true)
    chunk_file.binmode
    chunk_file.write(file.read(length))
    chunk_file.close
    chunk_file
  end

  def audio_to_text(file, format)
    retries = 0
    temp_file = convert_to_format(file, format)

    response = client.audio.transcribe(
      parameters: {
        model: 'whisper-1',
        file: File.open(temp_file),
        response_format: 'verbose_json',
      }
    )

    raise OpenAiError.new(response['error']['message']) if response['error'].present?

    response['segments'].map { |segment| { id: segment['id'], text: segment['text'], start: segment['start'], end: segment['end'] } }

  rescue OpenAiError => e
    if (retries += 1) <= MAX_RETRIES
      sleep WAIT_DURATION
      retry
    else
      return "Error after #{retries} retries: #{e.message}"
    end
  end

  def convert_to_format(file, format)
    temp_file = Tempfile.new(['audio', ".#{format}"])
    system("yes | ffmpeg -i #{file.path} -acodec copy #{temp_file.path}")
    temp_file
  end

  def client
    @client ||= OpenAI::Client.new
  end

  def read_response(response)
    return response.flatten! if response.length <= 1

    first_response = response.first
    offset_time = first_response.is_a?(Array) ? response.first.last[:end] : response.first[:end]

    response.drop(1).each do |segment|
      segment.each do |entry|
        entry[:start] = (entry[:start] + offset_time).round(2)
        entry[:end] = (entry[:end] + offset_time).round(2)
        offset_time = entry[:end]
      end
    end

    response.flatten!
  end
end
