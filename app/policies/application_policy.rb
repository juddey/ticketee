class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    false
  end

  def show?
    scope.where(:id => record.id).exists?
  end

  def create?
    false
  end

  def new?
    user.try(:admin?) || record.project.has_manager?(user) || record.project.has_editor?(user)
  end

  def update?
    user.try(:admin?) || record.project.has_manager?(user) || (record.project.has_editor?(user) && record.author == user)
 #   user.try(:admin?) || record.roles.exists?(user_id: user, role: 'manager')
 #   false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end
end

