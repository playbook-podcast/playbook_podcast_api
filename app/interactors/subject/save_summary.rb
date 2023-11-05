# frozen_string_literal: true

class Subject::SaveSummaryContext < ActiveInteractor::Context::Base
  attributes :subject, :summary

  validates :subject, :summary, presence: true, on: :calling
end

class Subject::SaveSummary  < ActiveInteractor::Base
  def perform
    context[:subject].summary = context.summary

    unless context[:subject].save
      context.errors.add(:base, 'Subject was not created')
      context.fail!(context[:subject].errors)
    end
  end
end
