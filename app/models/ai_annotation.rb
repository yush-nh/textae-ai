class AiAnnotation < ApplicationRecord
  before_create :clean_old_annotations
  before_create :set_uuid

  scope :old, -> { where("created_at < ?", 1.day.ago) }

  private

  def clean_old_annotations
    AiAnnotation.old.destroy_all
  end

  def set_uuid
    self.uuid = SecureRandom.uuid
  end
end
