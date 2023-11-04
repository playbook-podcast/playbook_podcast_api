class Api::V1::SubjectsController < ApplicationController
  def index
    subjects = Subject.order(created_at: :desc)

    if subjects.any?
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
end
