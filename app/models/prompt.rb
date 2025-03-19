class Prompt
  include ActiveModel::Model
  include ActiveModel::Attributes

  attr_accessor :text, :prompt

  def annotate!
    AiAnnotation.generate!(@text, @prompt)
  end
end
