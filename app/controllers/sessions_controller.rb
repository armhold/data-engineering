# controller to manage OpenID sessions
# largely cribbed from http://blog.sethladd.com/2010/09/ruby-rails-openid-and-google.html
#

class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def new
    response.headers['WWW-Authenticate'] = Rack::OpenID.build_header(
        :identifier => "https://www.google.com/accounts/o8/id",
        :required   => %w(http://axschema.org/contact/email http://axschema.org/namePerson/first http://axschema.org/namePerson/last),
        :return_to  => session_url,
        :method     => 'POST')
    head 401
  end

  def create
    if openid = request.env[Rack::OpenID::RESPONSE]
      case openid.status
      when :success
        ax    = OpenID::AX::FetchResponse.from_success_response(openid)
        user  = User.where(:identifier_url => openid.display_identifier).first
        user  ||= User.create!(:identifier_url => openid.display_identifier,
                               :email          => ax.get_single('http://axschema.org/contact/email'),
                               :first_name     => ax.get_single('http://axschema.org/namePerson/first'),
                               :last_name      => ax.get_single('http://axschema.org/namePerson/last'))
        session[:user_id] = user.id
        if user.first_name.blank?
          redirect_to(user_additional_info_url(user))
        else
          redirect_to(session[:redirect_to] || root_url)
        end
      when :failure
        render :action => 'problem'
      end
    else
      redirect_to new_session_url
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end

end
