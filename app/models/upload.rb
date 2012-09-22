# represents a set of purchases uploaded via tab-separated file
#
class Upload < ActiveRecord::Base
  has_many :purchases

  def gross_revenue
    purchases.inject(0) { |sum, purchase| sum + purchase.gross_revenue }
  end

end
