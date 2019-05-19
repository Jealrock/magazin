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
end
