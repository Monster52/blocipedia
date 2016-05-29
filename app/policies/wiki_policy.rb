class WikiPolicy < ApplicationPolicy
  attr_reader :user, :wiki

  def update?
    user.present?
  end

  def destroy?
    user.admin?
  end

  def new?
    user.present?
  end
end
