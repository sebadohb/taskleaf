class Task < ApplicationRecord
  def self.ransackable_attribute(auth_object = nil)
    %w[name created_at]
  end
  def self.ransackable_attribute(auth_object = nil)
    []
  end
  validates :name, presence: true, length: { maximum: 30 }
  validate :validate_name_not_including_comma
  belongs_to :user
  has_one_attached :image

  
  scope :recent, -> { order(created_at: :desc)}


  private
  def validate_name_not_including_comma
    errors.add(:name, 'にカンマを含める事はできません') if name&.include?(',')
  end
end
