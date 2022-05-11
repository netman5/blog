# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
      user ||= User.new # guest user (not logged in)
      admin_privilege if user.admin?
      else
        can :read, Post
        user_privilege if user.present?
        manager_privilege if user.manager?
        moderator_privilege if user.moderator?
      end
  end

  private

  def user_privilege
    can :manage, Post, user_id: user.id
    can :create, [Comment, Like]
  end

  def manager_privilege
    can :manage , Comment
  end

  def moderator_privilege
    can :delete, [Post, Comment, Like]
  end

  def admin_privilege
    can :manage, all
  end
end