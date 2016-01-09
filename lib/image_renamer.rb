require_relative "exif_date_reader"
require "fileutils"

class ImageRenamer

  def initialize(images)
    @images = images
  end

  def chronological!(dry_run: false, verbose: false)
    @images.
      map { |image| [image, ExifDateReader.call(image)] }.
      sort_by { |file, date| date }.
      each_with_index do |(file, date), index|
        newname = date.strftime(filename_template(index+1))
        puts "#{file} -> #{newname}" if verbose
        FileUtils.mv(file, File.join(File.dirname(file), newname)) unless dry_run
      end
  end

  def filename_template(index)
    "%Y-%m-%d-%H%M_image_#{("%03d" % index)}.jpg"
  end

end
