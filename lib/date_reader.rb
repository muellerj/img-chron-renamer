require 'rubygems'
require 'bundler/setup'
require "exif"
require "date"

class DateReader
  def self.call(file)
    Exif::Data.new(file).date_time_original || File.new(file).ctime
  rescue
    puts "Cannot determine exif date for #{file}"
    File.new(file).ctime
  end
end
