class AnnotationConverter
  JSON2INLINE_API = URI("https://pubannotation.org/conversions/json2inline").freeze

  def to_inline(json)
    request = Net::HTTP::Post.new(JSON2INLINE_API)
    request["Content-Type"] = "application/json"
    request.body = json

    Net::HTTP.start(JSON2INLINE_API.host, JSON2INLINE_API.port, use_ssl: true) do |http|
      http.request(request).body.force_encoding("UTF-8")
    end
  end
end
