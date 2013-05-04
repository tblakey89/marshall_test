class Dealership < ActiveRecord::Base
  attr_accessible :name

  has_many :users, order: "created_at desc"

  validates :name, presence: true

  def to_time(the_time)
    if !the_time.nil?
      current_time = the_time.to_i/1000
      seconds = current_time % 60
      minutes = (current_time / 60) % 60
      hours = (current_time/3600)
      hours.to_s + ":" + format("%02d",minutes.to_s) + ":" + format("%02d",seconds.to_s)
    end
  end
end
