class Subject < ApplicationRecord
  has_one_attached :body_audio
  has_one_attached :intro_audio
  has_one_attached :summary_audio

  validates :title, :body, presence: true
end
