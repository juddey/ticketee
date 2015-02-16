class TicketPolicy < ApplicationPolicy
  def show?
    user.try(:admin?) || record.project.has_member?(user)
  end
  def create?
    user.try(:admin?) || record.project.has_manager?(user) || record.project.has_editor?(user)
  end
  def destroy?
    user.try(:admin?) || record.project.has_manager?(user)
  end
  def change_state?
    destroy?
  end
  def tag?
    destroy?
  end
  class Scope < Scope
    def resolve
      scope
    end
  end
end
