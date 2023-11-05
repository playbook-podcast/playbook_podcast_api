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
  end

  private
  def synthesize_audio_context
    context.text = context[:subject].body
    context.filename = "#{context[:subject].id}_#{Time.now.to_s}"
  end
end
