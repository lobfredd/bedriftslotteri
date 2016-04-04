class Contactform < ActiveRecord::Base
  # This method associates the attribute ":img" with a file attachment
  has_attached_file :img

  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment :img, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
end
