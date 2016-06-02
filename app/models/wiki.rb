class Wiki < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]

  belongs_to :user
  has_many :collaborations
  has_many :users, through: :collaborations

  default_scope { order('created_at DESC') }
  scope :visible_to, -> (user) { user ? all : where(private: false) }

  def should_generate_new_friendly_id?
    new_record?
  end
end
