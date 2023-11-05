class AddSummaryTranscriptionToSubject < ActiveRecord::Migration[7.0]
  def change
    add_column :subjects, :summary_transcription, :jsonb
  end
end
