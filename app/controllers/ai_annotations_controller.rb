class AiAnnotationsController < ApplicationController
  def show
    @ai_annotation = AiAnnotation.find_by!(uuid: params[:uuid])
  end

  def new; end

  def create
    text = params[:text] || AnnotationConverter.to_inline(params[:textae_annotation])
    prompt = params[:prompt]
    ai_annotation = AiAnnotation.generate!(text, prompt)

    redirect_to "/ai_annotations/#{ai_annotation.uuid}"
  rescue => e
    Rails.logger.error "Error: #{e.message}"
    flash.now[:alert] = "Unexpected error occurred while generating AI annotation."
    @ai_annotation = AiAnnotation.find_by(uuid: params[:uuid])

    if @ai_annotation
      render :show, status: :unprocessable_entity
    else
      render :new, status: :unprocessable_entity
    end
  end
end
