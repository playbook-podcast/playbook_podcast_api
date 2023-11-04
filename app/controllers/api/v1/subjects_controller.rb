class Api::V1::SubjectsController < ApplicationController
  def show
    subject = Subject.find_by(id: params[:id])

    if subject
      render json: subject, serializer: SubjectSerializer
    else
      render json: { error: 'Unable to find subject', status: 404 }
    end
  end
end
