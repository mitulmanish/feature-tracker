class Project < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true, length: {in: 4..15}
  validates :description, presence: true, length: {in: 10..255}

  def to_s
    "#{name}:  #{description}"
  end
end
