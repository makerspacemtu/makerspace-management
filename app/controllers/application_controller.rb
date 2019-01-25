class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # don't cause a hard error when there is a permission issue,
  # catch it and display a nice error message or response
  # https://github.com/CanCanCommunity/cancancan#3-handle-unauthorized-access
  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden, content_type: 'text/html' }
      format.html { redirect_to main_app.root_url, notice: exception.message }
      format.js   { head :forbidden, content_type: 'text/html' }
    end
  end

  def respond_modal_with(*args, &blk)
    options = args.extract_options!
    options[:responder] = ModalResponder
    respond_with *args, options, &blk
  end

  # override the Devise path after a user is signed in, for more information:
  # https://github.com/plataformatec/devise/wiki/How-To:-redirect-to-a-specific-page-on-successful-sign-in
  def after_sign_in_path_for(resource)
   user_path(current_user)
  end
end
