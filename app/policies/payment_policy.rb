class PaymentPolicy < ApplicationPolicy
  def create?
    @user
  end

  def update?
    @user && @record.payable_entity.user_id == @user.id
  end
end
