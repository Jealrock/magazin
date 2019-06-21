class CategorySubscriptionPolicy < ApplicationPolicy
  def create?
    @user
  end
end
