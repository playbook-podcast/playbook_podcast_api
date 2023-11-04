# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Subject::ManageAudioSynthesis, vcr: { record: :none } do
  let(:test_subject) { create(:subject) }

  let(:interactor) do
    described_class.perform(subject: test_subject)
  end

  it 'attaches synthesized audio to the subject', vcr_cassette: 'Subject/manage_audio_synthesis' do
    expect(interactor.success?).to be(true)
    expect(test_subject.body_audio).to be_attached
  end
end
