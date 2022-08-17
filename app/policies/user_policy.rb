class UserPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    update?
  end

  def update?
    user.id == record.id
  end
end
