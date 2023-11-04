FactoryBot.define do
  factory :subject do
    title { "MyString" }
    body { "MyText" }
    summary { "MyText" }
    intro_audio { nil }
    body_audio { nil }
    summary_audio { nil }
    body_transcription { "" }
  end
end
