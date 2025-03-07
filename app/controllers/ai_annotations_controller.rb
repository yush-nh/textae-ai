class AiAnnotationsController < ApplicationController
  def show
    @ai_annotation = AiAnnotation.find_by!(uuid: params[:uuid]).content
  end

  def new; end

  def create
    text = params[:text]
    prompt = params[:prompt]
    inline_annotation = AiAnnotation.generate!(text, prompt)
    ai_annotation = AiAnnotation.create!(content: inline_annotation)

    redirect_to "/ai_annotations/#{ai_annotation.uuid}"
  rescue => e
    Rails.logger.error "Error: #{e.message}"
    flash.now[:alert] = "Unexpected error occurred while generating AI annotation."
    render :new, status: :internal_server_error
  end
end
