# defines a user for authentication purposes
#
# identifier_url is used to specify the OpenID URL that identifies the user

class User < ActiveRecord::Base
  attr_accessible :email, :identifier_url
  attr_accessible :first_name, :last_name

  def name_formatted
    "#{first_name} #{last_name}"
  end

end
