class Person < ActiveRecord::Base
  include Contactable

  validates :first_name, :last_name, presence: true
end
