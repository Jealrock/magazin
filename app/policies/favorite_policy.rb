class FavoritePolicy < ApplicationPolicy
  def create?
    @user
  end
end
