class Company < ActiveRecord::Base
  include Contactable

  validates :name, presence: :true

  def to_s
    "#{name}"
  end
end
