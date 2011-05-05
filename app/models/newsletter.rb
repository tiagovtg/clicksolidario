class Newsletter < ActiveRecord::Base
  validates :nome, :email, :presence => true
  validates :email, :uniqueness => true
end
