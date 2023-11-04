# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Subject::SaveAudioToSubject, type: :interactor do
  let(:test_subject) { create(:subject) }
  let(:audio_data) { 'mocked_audio_data' }
  let(:interactor) { described_class.perform(subject: test_subject, audio: audio_data) }

  before { interactor }

  describe 'attaching audio' do
    it 'successfully attaches audio to the subject' do
      expect(interactor.success?).to be(true)
      expect(test_subject.body_audio).to be_attached
    end

    it 'uses the correct naming convention for the attached file' do
      filename = test_subject.body_audio.filename.to_s
      expect(filename).to match(/#{test_subject.id}_\d+\.mp3/)
    end
  end
end
