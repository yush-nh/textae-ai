class Annotation
  include ActiveModel::Model
  include ActiveModel::Attributes

  attr_reader :content
  attr_accessor :prompt, :uuid

  def content=(value)
    @content = AnnotationConverter.new.to_inline(value)
  end

  def annotate!
    AiAnnotation.generate!(@content, @prompt)
  end
end
