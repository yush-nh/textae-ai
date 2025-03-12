class AnnotationConverter
  @uri = URI.parse("https://pubannotation.org/conversions/json2inline")

  class << self
    def to_inline(json)
      http = prepare_http
      request = prepare_request
      request.body = json

      http.request(request).body.force_encoding("UTF-8")
    end

    private

    def prepare_http
      http = Net::HTTP.new(@uri.host, @uri.port)
      http.use_ssl = true
      http
    end

    def prepare_request
      request = Net::HTTP::Post.new(@uri.request_uri)
      request["Content-Type"] = "application/json"
      request
    end
  end
end
