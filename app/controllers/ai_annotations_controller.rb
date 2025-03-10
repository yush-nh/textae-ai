class AiAnnotationsController < ApplicationController
  def show
    @ai_annotation = AiAnnotation.find_by!(uuid: params[:uuid]).content
  end
end
