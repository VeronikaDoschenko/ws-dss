require "refinery/core/authorisation_manager"
require "wsdss_refinery_authentication/authorisation_adapter"

module WsdssRefineryAuthentication
  class AuthorisationManager < Refinery::Core::AuthorisationManager

    # The user needs to be an admin to access Refinery's backend.
    def authenticate!
      unless adapter.current_user.admin?
        raise Zilch::Authorisation::NotAuthorisedException
      end

      adapter.current_user
    end

    # Override the default adapter specified in the superclass.
    def default_adapter
      @default_adapter ||= WsdssRefineryAuthentication::AuthorisationAdapter.new
    end

    # This allows a user to be supplied, bypassing the usual detection.
    def set_user!(user)
      adapter.current_user = user
    end
  end
end
