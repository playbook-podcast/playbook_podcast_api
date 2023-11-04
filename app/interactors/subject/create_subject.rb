# frozen_string_literal: true

class Subject::CreateSubjectContext < ActiveInteractor::Context::Base
  attributes :subject

  validates :subject, presence: true, on: :calling
end

class Subject::CreateSubject < ActiveInteractor::Base
  def perform
    unless context.subject.save
      context.errors.add(:base, 'Subject was not created')
      context.fail!(context[:subject].errors)
    end
  end
end
