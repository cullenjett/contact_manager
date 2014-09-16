class Company < ActiveRecord::Base
  include Contactable

  validates :name, presence: :true
end
