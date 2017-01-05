module WsdssRefineryAuthenticationAdminControllerDecorator

  private
  def authorisation_manager
    # defined in app/decorators/controllers/action_controller_base_decorator.rb
    refinery_authorisation_manager
  end
end

Refinery::AdminController.send :prepend, WsdssRefineryAuthenticationAdminControllerDecorator