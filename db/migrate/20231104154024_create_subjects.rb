class CreateSubjects < ActiveRecord::Migration[7.0]
  def change
    create_table :subjects do |t|
      t.string :title
      t.text :body
      t.text :summary
      t.jsonb :body_transcription

      t.timestamps
    end
  end
end
