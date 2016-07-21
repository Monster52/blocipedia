class WikiPolicy < ApplicationPolicy
  attr_reader :user, :wiki

  def initialize(user, wiki)
    @user = user
    @wiki = wiki
  end

  def show?
    user.present?
  end

  def update?
    user.present? || ( wiki.private? || ( wiki.user == user || wiki.users.include?(user)))
  end

  def destroy?
    user.admin? if user
  end

  def new?
    user.present?
  end


  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if !user.present?
        wikis = public_records
      elsif user.standard?
        wikis = (public_records + owned_records + shared_records).uniq
      elsif user.admin?
        wikis = scope.all
      elsif user.premium?
        wikis = (public_records + private_and_owned_records + shared_records).uniq
      end
      return sorted_by_last_updated(wikis)
    end

    private
    def private_and_owned_records
      scope.where(:private => true).where(:user_id => user.id)
    end

    def owned_records
      scope.where(:user_id => user.id)
    end

    def public_records
      scope.where(:private => false)
    end

    def shared_records
      scope.joins(:collaborations).where("collaborations.user_id = #{user.id}")
    end

    def sorted_by_last_updated(records)
      records.sort_by{|e| e.updated_at }.reverse!
    end

  end
end
