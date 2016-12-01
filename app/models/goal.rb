class Goal < ApplicationRecord

  before_validation :titleize_name

  belongs_to :user
  validates :name, presence: true,
                   uniqueness: { case_sensitive: false,
                      message: 'must be unique' }

  validates :minutes, presence: true

  def user_full_name
    if user
      user.full_name
    else
      'Anonymous'
    end
  end

  def user_first_name
    user ? user.first_name : "Anonymous"
  end

  def user_last_name
    user ? user.last_name : "Anonymous"
  end


  private

  def titleize_name
    self.name = name.titleize if name.present?
  end
end
