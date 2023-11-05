# frozen_string_literal: true

class Subject::SaveAudioToSubjectContext < ActiveInteractor::Context::Base
  attributes :subject, :audio, :audio_type

  validates :subject, :audio, :audio_type, presence: true, on: :calling
end

class Subject::SaveAudioToSubject < ActiveInteractor::Base
  def perform
    attach_audio_to_subject

    unless context.subject.save
      context.errors.add(:base, 'Failed to save audio to subject')
      context.fail!(context[:subject].errors)
    end
  end

  private

  def attach_audio_to_subject
    context.subject.body_audio.attach(
      io: StringIO.new(context.audio),
      filename:,
      content_type: 'audio/mpeg'
    )
  end

  def filename
    "#{context[:subject].id}_#{Time.now.to_i}.#{context.audio_type}"
  end
end
