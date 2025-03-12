class AnnotationConverter
  JSON2INLINE_API = "https://pubannotation.org/conversions/json2inline".freeze

  def initialize
    uri = URI.parse(JSON2INLINE_API)
    @http = prepare_http(uri)
    @request = prepare_request(uri)
  end

  def to_inline(json)
    @request.body = json

    @http.request(@request).body.force_encoding("UTF-8")
  end

  private

  def prepare_http(uri)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http
  end

  def prepare_request(uri)
    request = Net::HTTP::Post.new(uri.request_uri)
    request["Content-Type"] = "application/json"
    request
  end
end
