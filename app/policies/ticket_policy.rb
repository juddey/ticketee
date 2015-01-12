class TicketPolicy < ApplicationPolicy
  def show?
    user.try(:admin?) || record.project.roles.exists?(user_id: user)
  end
  class Scope < Scope
    def resolve
      scope
    end
  end
end
