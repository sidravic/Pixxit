class User < ActiveRecord::Base
  has_many :posts, :dependent => :destroy
  has_one :profile
  after_create :generate_account_slug
  after_create :generate_profile

  acts_as_authentic

  def self.find_by_activated_user(email)
    where("active = true AND email = ?", email).first
  end

  def activate!
    self.update_attributes(:active => true)
  end

  def generate_account_slug
    self.slug = "#{self.id}-#{self.name.split.join('-')}"
    save
  end

  def generate_profile
    default_blog_name = "#{self.name.camelcase}'s Photo Blog"
    self.create_profile(:blog_name => default_blog_name)
  end
end
