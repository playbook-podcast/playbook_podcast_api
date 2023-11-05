# frozen_string_literal: true

class Subject::ManageAudioSynthesisContext < ActiveInteractor::Context::Base
  attributes :subject

  validates :subject, presence: true, on: :calling
end

class Subject::ManageAudioSynthesisOrganizer < ActiveInteractor::Organizer::Base
  organize do
    add Subject::CreateSubject
    add SynthesizeAudio, before: -> { synthesize_audio_context }
    add Subject::SaveAudioToSubject
    add GetAudioTranscription, before: -> { get_audio_transcription_context }
    add Subject::SaveTranscription
    add Subject::ManageSummaryGenerationOrganizer
  end

  private

  def synthesize_audio_context
    context.text = context[:subject].body
    context.filename = "#{context[:subject].id}_#{Time.now.to_s}"
  end

  def get_audio_transcription_context
    context.audio_blob = context[:subject].body_audio.blob
  end
end
