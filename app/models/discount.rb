class Discount < ActiveRecord::Base
  has_and_belongs_to_many :users

  def fraction
    (100-self.percent)/100
  end
  
end

 
