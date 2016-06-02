Given(/^I have a folder with the following images$/) do |table|
  @dir = Dir.mktmpdir
  table.raw[1..-1].each do |name, date|
    File.open(File.join(@dir, name), "w+") do |file|
      file.puts date
    end
  end
end

When(/^I invoke the renamer in that directory$/) do
  def DateReader.call(file)
    DateTime.parse(File.read(file))
  end
  ImageRenamer.new(@dir).chronological!
end

Then(/^listing the content of the folder should yield the following result$/) do |string|
  expect(`ls #{@dir}`.chomp).to eq string
  FileUtils.rm_rf(@dir)
end
