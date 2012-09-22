class User < ActiveRecord::Base
  attr_accessible :email, :identifier_url
  attr_accessible :first_name, :last_name

  def name_formatted
    "#{first_name} #{last_name}"
  end

end
