class Post < ActiveRecord::Base
  belongs_to :user
  has_many :images, :dependent => :destroy

  accepts_nested_attributes_for :images

  validates :title, :presence => true
  validates :images, :presence => true

  def publish!
    self.update_attributes(:published => true)
  end

  def unpublish!
    self.update_attributes(:published => false)
  end

  def last_image?
    (self.images.length == 1)
  end
end
