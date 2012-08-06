require 'csv'

namespace :data do
  desc "read original NA 86 Data"
  task :read_original => :environment do |t|
    f = File.join( Rails.root, 'tmp', 'na86-data.txt' )
    puts "----------------------------------------------------------------------------------------------"
    puts "[#{DateTime.now}] reading original NA86 data [#{f}]"
    puts "----------------------------------------------------------------------------------------------"
    data = {}
    File.open( f, "r") do |file|
      while ( line = file.gets )
        ship_data = line.split /^(\w+)-{1}([\w+\s?]+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)$/
        if ship_data[12]
        data[ship_data[12].strip] = [
          ship_data[1] ? ship_data[1].strip : ship_data[1],
          "",
          ship_data[2] ? ship_data[2].strip : ship_data[2],
          ship_data[3] ? ship_data[3].strip : ship_data[3],
          ship_data[4] ? ship_data[4].strip : ship_data[4],
          ship_data[5] ? ship_data[5].strip : ship_data[5],
          ship_data[6] ? ship_data[6].strip : ship_data[6],
          ship_data[7] ? ship_data[7].strip : ship_data[7],
          ship_data[8] ? ship_data[8].strip : ship_data[8],
          ship_data[9] ? ship_data[9].strip : ship_data[9],
          ship_data[10] ? ship_data[10].strip : ship_data[10],
          ship_data[11] ? ship_data[11].strip : ship_data[11],
          ship_data[12] ? ship_data[12].strip : ship_data[12]
        ]
      end
      end
    end
    csv_file = File.join( Rails.root, 'tmp', 'na86-data.csv' )
    File.open( csv_file, 'w' ) do |io|
      data.each do |k,v|
        io.write v.join( "," ) + "\r"
      end
    end
  end
end