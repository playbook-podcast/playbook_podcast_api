# frozen_string_literal: true

class Subject::GenerateSummaryContext < ActiveInteractor::Context::Base
  attributes :subject, :summary

  validates :subject, presence: true, on: :calling
end

class Subject::GenerateSummary < ActiveInteractor::Base
  def perform
    chat_service = ChatGptService.new
    main_message = "You are a helpful assistant."
    message_content = context.subject.body
    context.summary = chat_service.chat(main_message, message_content)
  end
end

