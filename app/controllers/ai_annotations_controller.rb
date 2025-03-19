class AiAnnotationsController < ApplicationController
  def show
    @ai_annotation = AiAnnotation.find_by!(uuid: params[:uuid])
    @new_ai_annotation = AiAnnotation.new
  end

  def new
    @new_ai_annotation = AiAnnotation.new
  end

  def create
    text = ai_annotation_params[:text] || AnnotationConverter.new.to_inline(ai_annotation_params[:textae_annotation])
    prompt = ai_annotation_params[:prompt]
    @new_ai_annotation = AiAnnotation.prepare_with(text, prompt)
    ai_annotation = @new_ai_annotation.annotate!

    redirect_to "/ai_annotations/#{ai_annotation.uuid}"
  rescue => e
    Rails.logger.error "Error: #{e.message}"
    flash.now[:alert] = "Unexpected error occurred while generating AI annotation."
    @ai_annotation = AiAnnotation.find_by(uuid: ai_annotation_params[:uuid])

    if @ai_annotation
      render :show, status: :unprocessable_entity
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def ai_annotation_params
    params.require(:ai_annotation).permit(:text, :prompt, :uuid, :textae_annotation)
  end
end
