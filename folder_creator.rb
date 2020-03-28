require 'fileutils'
require 'csv'

admit_201915_array = []

CSV.foreach('data/MOCK__STUDENT_DATA.csv', headers: true) do |header|
  if header["Term Code Admit"] == "201915"
    admit_201915_array << header["Univ Id"]
    admit_201915_array << header["Student"]
  end
end

admit_201915 = Hash[*admit_201915_array]

def folders(admit_201915)
  admit_201915.each { |id, name|
    name = name.split(" ")
    first_name = name[-1]
    last_name = name[0]
    Dir.mkdir "output/#{last_name}-#{first_name}-#{id}"
    Dir.mkdir "output/#{last_name}-#{first_name}-#{id}/forms"
    Dir.mkdir "output/#{last_name}-#{first_name}-#{id}/plans-of-study"
    Dir.mkdir "output/#{last_name}-#{first_name}-#{id}/plans-of-study/undergraduate"
    Dir.mkdir "output/#{last_name}-#{first_name}-#{id}/plans-of-study/bs-ms"
    FileUtils.cp 'master-2018+ plan of study.xlsx', "output/#{last_name}-#{first_name}-#{id}//plans-of-study/undergraduate/#{last_name}_#{first_name}_#{id}_UG_plan_of_study.xlsx"
  }
  puts "All created files can be found in the output folder."
end

folders(admit_201915)