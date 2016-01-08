require_relative "exif_date_reader"
require "awesome_print"
require "fileutils"

class ImageRenamer

  def initialize(images)
    @images = images
  end

  def chronological!
    list = @images.
      map { |image| [image, ExifDateReader.call(image)] }.
      sort_by { |file, date| date }

    list.each_with_index do |(file, date), index|
      newname = date.strftime("%Y-%m-%d-%H%M_image_#{("%03d" % (index+1))}.jpg")
      FileUtils.mv(file, File.join(File.dirname(file), newname))
    end
  end

end
