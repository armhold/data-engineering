# represents a set of purchases uploaded via tab-separated file
#
class Upload < ActiveRecord::Base
  has_many :purchases

end
