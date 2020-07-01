class Utils::Csv
  def self.split_csv(input_file, lines_per_file: 30_000, path: 'csv_files/')
    total_lines = `wc -l #{input_file} | awk '{print $1}'`.to_i
    file_lines = ''
    line_count = 0
    file_count = 1
    generated_files = []
    IO.readlines(input_file).each do |line|
      file_lines += line
      line_count += 1
      puts "line_count: #{line_count}"
      if should_write?(line_count, lines_per_file, total_lines)
        file_name = file_name(input_file, file_count)
        generated_files.push(file_name)
        File.open("#{path}#{file_name}", 'w') { |f| f.puts file_lines }
        file_lines = ''
        line_count = 0
        file_count += 1
      end
    end

    generated_files
  end

  def self.file_name(input_file, n)
    file_extension = File.extname(input_file)
    file_name = File.basename(input_file, file_extension)
    return "#{file_name}_#{n}#{file_extension}"
  end

  def self.should_write?(line_count, lines_per_file, total_lines)
    (line_count % lines_per_file == 0) || (line_count == total_lines)
  end
end
