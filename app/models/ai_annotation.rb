class AiAnnotation < ApplicationRecord
  FORMAT_SPECIFICATION = <<~EOS
    Annotate text using the following syntax:

    ## Annotation Structure
    - An annotation is represented by two consecutive pairs of square brackets:
      - First pair: annotated text
      - Second pair: label
    - Example: [Annotated Text][Label]

    ## Label Definition (Optional)
    - Define labels with a square bracket followed by `:` and a URL.
    - Example: [Label]: URL

    ## Metacharacter Escaping
    - The annotation structure (two consecutive pairs of square brackets) is rarely appear in normal text.
      If it does occur, it may be misinterpreted as an annotation.
      To avoid this, the first opening square bracket must be escaped with a backslash (\).
    - Example: \[This is a part of][original text]

    Follow the prompt for annotation labels.
    Output should be the original text with annotations.
  EOS

  before_create :clean_old_annotations
  before_create :set_uuid

  scope :old, -> { where("created_at < ?", 1.day.ago) }

  def self.generate!(text, prompt)
    # To reduce the risk of API key leakage, API error logging is disabled by default.
    # If you need to check the error details, enable logging by add argument `log_errors: true` like: OpenAI::Client.new(log_errors: true)
    client = OpenAI::Client.new
    response = client.chat(
      parameters: {
        model: "gpt-4o",
        messages: [
          { role: "system", content: FORMAT_SPECIFICATION },
          { role: "user", content: "text: #{text} prompt: #{prompt}" }
        ]
      }
    )

    response.dig("choices", 0, "message", "content")
  end

  private

  def clean_old_annotations
    AiAnnotation.old.destroy_all
  end

  def set_uuid
    self.uuid = SecureRandom.uuid
  end
end
