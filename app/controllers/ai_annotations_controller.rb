class AiAnnotationsController < ApplicationController
  def show
    @ai_annotation = AiAnnotation.find_by!(uuid: params[:uuid])
    @annotation = Annotation.new
  end

  def new
    @prompt = Prompt.new
  end

  def create
    ai_annotation =
      if params[:prompt]
        @prompt = Prompt.new(prompt_params)
        @prompt.annotate!
      elsif params[:annotation]
        @annotation = Annotation.new(annotation_params)
        @annotation.annotate!
      end
    raise RuntimeError
    redirect_to "/ai_annotations/#{ai_annotation.uuid}"
  rescue => e
    Rails.logger.error "Error: #{e.message}"
    flash.now[:alert] = "Unexpected error occurred while generating AI annotation."

    if @annotation
      @ai_annotation = AiAnnotation.find_by(uuid: annotation_params[:uuid])
      render :show, status: :unprocessable_entity
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def prompt_params
    params.require(:prompt).permit(:text, :prompt)
  end

  def annotation_params
    params.require(:annotation).permit(:content, :prompt, :uuid)
  end
end
