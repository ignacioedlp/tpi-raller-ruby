class OpeningHourPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  def index?
    @user.has_any_role? :admin, :staff, :client
  end

  def show?
    @user.has_any_role? :admin, :staff, :client
  end

  def destroy?
    @user.has_role? :admin
  end

  def edit?
    @user.has_role? :admin
  end

  def update?
    @user.has_role? :admin
  end
end
