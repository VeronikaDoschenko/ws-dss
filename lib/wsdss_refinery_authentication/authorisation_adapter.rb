require "refinery/core/authorisation_adapter"

module WsdssRefineryAuthentication
  class AuthorisationAdapter < Refinery::Core::AuthorisationAdapter

    # If no user exists, we should use a blank User (non-admin).
    def current_user
      @current_user ||= User.new
    end

    # This method has been added, it does not exist in the superclass.
    def current_user=(set_to_this_user)
      @current_user = set_to_this_user
    end

    def allow?(operation, resource)
      case
      when resource == :site_bar
        Ability.new(current_user).can? :manage, :cms
      when operation == :plugin
        Ability.new(current_user).can? :manage, :cms
      when operation == :controller
        Ability.new(current_user).can? :manage, :cms
      else
        false
      end
    end

  end
end
