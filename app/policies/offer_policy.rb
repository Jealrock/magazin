class OfferPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    @user
  end

  def close?
    @user && @user.id == @record.user_id
  end
end
