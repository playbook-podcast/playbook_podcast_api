# frozen_string_literal: true

class Subject::SaveIntroContext < ActiveInteractor::Context::Base
  attributes :subject, :intro

  validates :subject, :intro, presence: true, on: :calling
end

class Subject::SaveIntro  < ActiveInteractor::Base
  def perform
    context[:subject].intro = context.intro

    unless context[:subject].save
      context.errors.add(:base, 'Subject was not created')
      context.fail!(context[:subject].errors)
    end
  end
end
