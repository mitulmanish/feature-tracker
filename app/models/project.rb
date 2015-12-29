class Project < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true, length: {in: 4..25}
  validates :description, presence: true, length: {in: 10..255}
  has_many :tickets, dependent: :delete_all

  def to_s
    "#{name}:  #{description}"
  end
end
