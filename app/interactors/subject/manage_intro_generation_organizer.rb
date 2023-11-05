# frozen_string_literal: true

class Subject::ManageIntroGenerationOrganizerContext < ActiveInteractor::Context::Base
  attributes :subject

  validates :subject, presence: true, on: :calling
end

class Subject::ManageIntroGenerationOrganizer < ActiveInteractor::Organizer::Base
  organize do
    add Subject::GenerateIntro
    add Subject::SaveIntro
    add SynthesizeAudio, before: -> { synthesize_audio_context }
    add Subject::SaveIntroAudioToSubject
    add GetAudioTranscription, before: -> { get_audio_transcription_context }
    add Subject::SaveIntroTranscription
  end

  private
  def synthesize_audio_context
    context.text = context[:subject].intro
    context.filename = "#{context[:subject].id}_#{Time.now.to_s}"
  end

  def get_audio_transcription_context
    context.audio_blob = context[:subject].intro_audio.blob
  end
end
