class AiAnnotationsController < ApplicationController
  def show
    @ai_annotation = AiAnnotation.find_by!(uuid: params[:uuid])
  end

  def new; end

  def create
    text = params[:text] || textae_annotation
    prompt = params[:prompt]
    ai_annotation = AiAnnotation.generate!(text, prompt)

    redirect_to "/ai_annotations/#{ai_annotation.uuid}"
  rescue => e
    Rails.logger.error "Error: #{e.message}"
    flash.now[:alert] = "Unexpected error occurred while generating AI annotation."

    if params[:uuid]
      @ai_annotation = AiAnnotation.find_by!(uuid: params[:uuid])
      render :show, status: :unprocessable_entity
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def textae_annotation
    uri = URI.parse("https://pubannotation.org/conversions/json2inline")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(uri.request_uri)
    request["Content-Type"] = "application/json"
    request.body = params[:textae_annotation]

    http.request(request).body.force_encoding('UTF-8')
  end
end
