class Article < ActiveRecord::Base

  has_many :comments, dependent: :destroy
  validates :title, presence: true, length: { minimum: 5 }

  extend FriendlyId
  friendly_id :name, use: :slugged

  # Метод позволяет менять url не только при создании новой статьи, но
  # и при изменении атрибута name в уже существующей:
  def should_generate_new_friendly_id?
    name_changed?
  end

end
