class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def archive
    self.update(archived_at: Time.now)
  end

  def unarchive
    self.update(archived_at: nil)
  end

  def active_for_authentiation?
    super && archived_at.nil?
  end

  def inactive_message
    archived_at.nil? ? super : :archived
  end

end
