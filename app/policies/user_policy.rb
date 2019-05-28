class UserPolicy < ApplicationPolicy
  def update?
    @user && @user.id == @record.id
  end
end
