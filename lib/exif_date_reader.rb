require 'rubygems'
require 'bundler/setup'
require "exif"
require "date"

class ExifDateReader
  def self.call(file)
    Exif::Data.new(file).date_time_original || fail
  rescue
    fail "Cannot determine date for #{file}"
  end
end
