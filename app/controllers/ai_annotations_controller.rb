class AiAnnotationsController < ApplicationController
  def show
    @ai_annotation = AiAnnotation.find_by!(uuid: params[:id])
  end
end
