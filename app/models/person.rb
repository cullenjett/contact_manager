class Person < ActiveRecord::Base
  include Contactable

  validates :first_name, :last_name, presence: true

  def to_s
    "#{last_name}, #{first_name}"
  end
end
