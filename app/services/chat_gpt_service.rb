# frozen_string_literal: true

class ChatGptService
  MODEL = "gpt-3.5-turbo"

  def initialize
    @client = OpenAI::Client.new
  end

  def chat(main_message, message, temperature: 0.7)
    response = @client.chat(
      parameters: {
        model: MODEL,
        messages: [{ role: :system, content: main_message },{ role: "user", content: message }],
        temperature: temperature
      }
    )

    # Extract the content from the response
    response.dig("choices", 0, "message", "content")
  rescue => e
    raise "Error chatting with GPT: #{e.message}"
  end
end
