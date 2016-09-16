class WsJob < ActiveRecord::Base
  nilify_blanks
  belongs_to :ws_method
  belongs_to :user
  validate :file_size_and_type
  

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
    xxx = super
    if @file
      self.filename = sanitize_filename(@file.original_filename)
      self.content_type = @file.content_type
      @file.rewind
      self.file_contents = @file.read
      self.save
    end
    xxx
  end

  def do_job
    a = self.ws_method.do_calc(self.input)
    self.output = a[0]
    self.error_code = a[1]
    self.for_check  = a[2]
    self.save
  end
  
private
  def sanitize_filename(filename)
    # Get only the filename, not the whole path (for IE)
    # Thanks to this article I just found for the tip: http://mattberther.com/2007/10/19/uploading-files-to-a-database-using-rails
    return File.basename(filename)
  end
  NUM_BYTES_IN_MEGABYTE = 1048576
  def file_size_and_type
    if @file 
      if (@file.size.to_f / NUM_BYTES_IN_MEGABYTE) > 4
        errors.add(:file, 'File size cannot be over 4 megabyte.')
      elsif @file.content_type != 'application/pdf'
        errors.add(:file, 'File type must be pdf only!')
      end
    end
  end
end
