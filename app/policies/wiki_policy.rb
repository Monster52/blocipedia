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
    user.present? && (
      wiki.private? || (
        user.admin? ||
        wiki.user == user ||
        wiki.users.include?(user)
      )
    )
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
      wikis = []
      if user.role == 'admin'
        wikis = scope.all # if the user is an admin, show them all the wikis
      elsif user.role == 'premium'
        all_wikis = scope.all
        all_wikis.each do |wiki|
          if public_records || wiki.owner == user || shared_records
            wikis << wiki # if the user is premium, only show them public wikis, or that private wikis they created, or private wikis they are a collaborator on
          end
        end
      else # this is the lowly standard user
        all_wikis = scope.all
        wikis = []
        all_wikis.each do |wiki|
          if wiki.user_id == user.id || !wiki.private? || wiki.collaborations.include?(user)
            wikis << wiki # only show standard users public wikis and private wikis they are a collaborator on
          end
        end
      end
      wikis # return the wikis array we've built up
    end

    private
     def private_and_owned_records
       scope.where(:private => true).where(:user_id => user.id)
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
