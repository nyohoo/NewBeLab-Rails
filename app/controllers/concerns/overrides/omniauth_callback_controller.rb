class Api::V1::Auth::OmniauthCallbacksController < DeviseTokenAuth::OmniauthCallbacksController
  def omniauth_success
    super
    @resource.update(nickname: @resource.name) if @resource.nickname.nil?
  end

  protected

  def assign_provider_attrs(user, auth_hash)
    case auth_hash['provider']
    when 'github'
      user.assign_attributes({
                               name: auth_hash['info']['name'],
                               image: auth_hash['info']['image'],
                               email: auth_hash['info']['email']
                             })
    else
      super
    end
  end

  def clean_resource
    @resource.name = strip_emoji(@resource.name)
  end

  def strip_emoji(str)
    str.encode('SJIS', 'UTF-8', invalid: :replace, undef: :replace,
                                replace: '').encode('UTF-8')
  end
end