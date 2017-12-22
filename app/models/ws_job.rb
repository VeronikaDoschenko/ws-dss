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
    self.output_data = a[3]
    if a[4][:io] and a[4][:type] and a[4][:name]
      self.filename = a[4][:name]
      self.content_type = a[4][:type]
      a[4][:io].rewind
      f = File.open(Rails.root.join('tmp', "#{self.id}_data.tmp"),'w')
      IO.copy_stream(a[4][:io], f)
      f.close
      ff = File.open(Rails.root.join('tmp', "#{self.id}_data.tmp"),'r')
      self.file_contents = ff.read
      ff.close
    end
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
      elsif FILE_TYPE_ACCEPTED.find{|e| e == @file.content_type}.nil?
        errors.add(:file, 'File type must be pdf or csv or json or xml only!')
      end
    end
  end
end
