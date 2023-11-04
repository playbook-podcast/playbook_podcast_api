# frozen_string_literal: true

class Subject::ManageAudioSynthesisContext < ActiveInteractor::Context::Base
  attributes :subject

  validates :subject, presence: true, on: :calling
end

class Subject::ManageAudioSynthesis < ActiveInteractor::Organizer::Base
  organize do
    add SynthesizeAudio, before: -> { context.text = context[:subject].body }
    add Subject::SaveAudioToSubject
  end
end
