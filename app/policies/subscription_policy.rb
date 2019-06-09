class SubscriptionPolicy < ApplicationPolicy
  def create?
    @user
  end
end
