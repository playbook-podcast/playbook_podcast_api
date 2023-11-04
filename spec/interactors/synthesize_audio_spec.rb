# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SynthesizeAudio, type: :interactor, vcr: { record: :none }  do
  let(:text) { 'Hello, World!' }

  let(:interactor) do
    described_class.perform(text: text)
  end

  it 'synthesizes the audio', vcr_cassette: 'GoogleTextToSpeechService/synthesize_speech' do
    expect(GoogleTextToSpeechService).to receive(:new).with(text).and_call_original

    expect(interactor.success?).to be(true)
    expect(interactor.audio).to be_present
  end
end
