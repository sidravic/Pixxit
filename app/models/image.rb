class Image < ActiveRecord::Base
    has_attached_file :photo, :styles => {:thumb => '100x300', :medium => '500x460', :large => '1000x1000'}, :default_url => '/images/placeholder_:style.jpg'

    validates_attachment_presence :photo#, :unless => :has_atleast_one_attachment?
    validates_attachment_size :photo, :less_than => 5.megabytes
    validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png', 'image/gif'],
                                       :message => "Please use a jpg, png or gif image."

end
