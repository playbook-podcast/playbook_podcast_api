# frozen_string_literal: true

class Subject::SaveTranscriptionContext < ActiveInteractor::Context::Base
  attributes :subject, :transcription

  validates :subject, :transcription, presence: true, on: :calling
end

class Subject::SaveTranscription < ActiveInteractor::Base
  def perform
    unless context[:subject].update(body_transcription: preperad_transcription)
      context.fail!(message: 'Failed to save transcription to subject')
    end
  end

  private
  def preperad_transcription
    transcriptions = context[:transcription].flatten!
    transcriptions.each do |transcription|
      transcription[:start] = (transcription[:start] * 1000).to_i
      transcription[:end] = (transcription[:end] * 1000).to_i
    end
  end
end
