require 'rubygems'
require 'bundler/setup'
require "exif"
require "date"

class DateReader
  def self.call(file)
    Exif::Data.new(file).date_time_original || File.new(file).ctime
  rescue
    fail "Cannot determine date for #{file}"
  end
end
