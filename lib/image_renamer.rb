require_relative "date_reader"
require "fileutils"

class ImageRenamer

  def initialize(image_dir)
    @images = Dir.glob(File.join(image_dir, "*.jpg"), File::FNM_CASEFOLD)
  end

  def chronological!(dry_run: false, verbose: false)
    @images.
      map { |image| [image, DateReader.call(image)] }.
      sort_by { |file, date| date }.
      each_with_index do |(file, date), index|
        newname = date.strftime(filename_template(index+1))
        unless newname.downcase == File.basename(file).downcase
          puts "#{File.basename(file)} -> #{newname}" if verbose
          FileUtils.mv(file, File.join(File.dirname(file), newname)) unless dry_run
        end
      end
  end

  def filename_template(index)
    "%Y-%m-%d-%H%M_image_#{("%03d" % index)}.jpg"
  end

end
