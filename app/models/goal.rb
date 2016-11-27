class Goal < ApplicationRecord

  before_validation :titleize_name

  belongs_to :user
  validates :name, presence: true,
                   uniqueness: { case_sensitive: false,
                      message: 'must be unique' }

  validates :minutes, presence: true

  private

  def titleize_name
    self.name = name.titleize if name.present?
  end
end
