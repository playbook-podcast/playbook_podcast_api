class Api::V1::SubjectsController < ApplicationController
  def index
    subjects = Subject.order(created_at: :desc)

    if subjects.exists?
      render json: subjects, each_serializer: SubjectsSerializer
    else
      render json: { error: 'No subjects', status: 204 }
    end
  end

  def show
    subject = Subject.find_by(id: params[:id])

    if subject
      render json: subject, serializer: SubjectSerializer
    else
      render json: { error: 'Unable to find subject', status: 404 }
    end
  end

  def create
    subject = Subject.new(subject_params)
    result = Subject::ManageAudioSynthesisOrganizer.perform(subject: )

    if result.success?
      render json: result.subject, serializer: SubjectSerializer
    else
      render json: { error: 'Subject was not created', status: 422 }
    end
  end

  private

  def subject_params
    params.require(:subject).permit(:title, :body)
  end
end
