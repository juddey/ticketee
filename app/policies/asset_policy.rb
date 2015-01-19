class AssetPolicy < ApplicationPolicy
  def show?
    user.try(:admin?) || record.ticket.project.has_member?(user)
  end
  class Scope < Scope
    def resolve
      scope
    end
  end
end
