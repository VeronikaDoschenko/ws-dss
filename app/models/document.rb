class Document < ActiveRecord::Base
  validate :file_size
  has_and_belongs_to_many :subjects
  def initialize(params = {})
    # File is now an instance variable so it can be
    # accessed in the validation.
    @file = params.delete(:file)
    super
    if @file
      self.filename = sanitize_filename(@file.original_filename)
      self.content_type = @file.content_type
      @file.rewind
      self.file_contents = @file.read
    end
  end
  def update(params = {})
    # File is now an instance variable so it can be
    # accessed in the validation.
    @file = params.delete(:file)
    super
    if @file
      self.filename = sanitize_filename(@file.original_filename)
      self.content_type = @file.content_type
      @file.rewind
      self.file_contents = @file.read
      self.save
    end    
  end
private
  def sanitize_filename(filename)
    # Get only the filename, not the whole path (for IE)
    # Thanks to this article I just found for the tip: http://mattberther.com/2007/10/19/uploading-files-to-a-database-using-rails
    return File.basename(filename)
  end
  NUM_BYTES_IN_MEGABYTE = 1048576
  def file_size
    if @file and (@file.size.to_f / NUM_BYTES_IN_MEGABYTE) > 20
      errors.add(:file, 'File size cannot be over 20 megabyte.')
    end
  end
end
