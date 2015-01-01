class ProjectPolicy < ApplicationPolicy
  def show?
    user.try(:admin) || record.roles.exists?(user_id: user)
  end
  class Scope < Scope
    def resolve
      scope
    end
 
  end
end
