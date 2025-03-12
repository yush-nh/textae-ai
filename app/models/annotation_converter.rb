class AnnotationConverter
  @uri = URI.parse("https://pubannotation.org/conversions/json2inline")

  def self.to_inline(json)
    http = Net::HTTP.new(@uri.host, @uri.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(@uri.request_uri)
    request["Content-Type"] = "application/json"
    request.body = json

    http.request(request).body.force_encoding("UTF-8")
  end
end
