# frozen_string_literal: true

class Subject::ManageSummaryGenerationOrganizerContext < ActiveInteractor::Context::Base
  attributes :subject

  validates :subject, presence: true, on: :calling
end

class Subject::ManageSummaryGenerationOrganizer < ActiveInteractor::Organizer::Base
  organize do
    add Subject::GenerateSummary
    add Subject::SaveSummary
    add SynthesizeAudio, before: -> { synthesize_audio_context }
    add Subject::SaveSummaryAudioToSubject
    add GetAudioTranscription, before: -> { get_audio_transcription_context }
    add Subject::SaveSummaryTranscription
  end

  private
  def synthesize_audio_context
    context.text = context[:subject].summary
    context.filename = "#{context[:subject].id}_#{Time.now.to_s}"
  end

  def get_audio_transcription_context
    context.audio_blob = context[:subject].summary_audio.blob
  end
end
