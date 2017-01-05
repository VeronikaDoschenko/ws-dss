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
        current_user.refinery? or current_user.admin?
      when operation == :plugin
        current_user.admin?
      when operation == :controller
        current_user.admin?
      else
        false
      end
    end

  end
end
