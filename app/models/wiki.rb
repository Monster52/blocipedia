class Wiki < ActiveRecord::Base
  belongs_to :user

  default_scope { order('created_at DESC') }
  scope :visible_to, -> (user) { user ? all : where(private: false) }

end
