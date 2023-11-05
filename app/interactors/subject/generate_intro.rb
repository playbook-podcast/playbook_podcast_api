# frozen_string_literal: true

class Subject::GenerateIntroContext < ActiveInteractor::Context::Base
  attributes :subject, :intro

  validates :subject, presence: true, on: :calling
end

class Subject::GenerateIntro < ActiveInteractor::Base
  def perform
    chat_service = ChatGptService.new
    main_message = "You are a helpful assistant."
    message_content = context.subject.body
    context.intro = chat_service.chat(main_message, message_content)
  end
end

