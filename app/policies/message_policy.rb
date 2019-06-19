class MessagePolicy < ApplicationPolicy
  def index?
    @user
  end

  def create?
    @user
  end
end
