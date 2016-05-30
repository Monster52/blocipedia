class WikiPolicy < ApplicationPolicy
  attr_reader :user, :wiki

  def initialize(user, wiki)
    @user = user
    @wiki = wiki
  end

  def index
    user.admin? || user.wikis.count
  end

  def show
    user.present && (user.admin? || wiki.user_id == user.id)
  end

  def update?
    user.present?
  end

  def destroy?
    user.admin?
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
         wikis = scope.all
       elsif user.role == 'premium'
         all_wikis = scope.all
         all_wikis.each do |wiki|
          if !wiki.private? || wiki.user == user
            wikis << wiki
          end
        end
       else
         all_wikis = scope.all
         wikis = []
         all_wikis.each do |wiki|
           if !wiki.private?
             wikis << wiki
           end
         end
       end
       wikis
     end
   end
 end
