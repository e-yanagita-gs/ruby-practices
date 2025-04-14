# frozen_string_literal: true

require_relative 'file_information'

class Display
  COLUMN_SIZE = 3

  def initialize(options)
    @options = options
    @files = list_files
    @file_informations = @files.map { |file| FileInformation.new(file) }
  end

  def output
    if @options[:l]
      output_files_in_long_format
    else
      output_files_default
    end
  end

  private

  def list_files
    flags = @options[:a] ? File::FNM_DOTMATCH : 0
    @options[:r] ? Dir.glob('*', flags).reverse : Dir.glob('*', flags)
  end

  def output_files_in_long_format
    calc_max_length
    puts "合計 #{@file_informations.map(&:block_size).sum}"
    @file_informations.each do |file_info|
      puts [
        "#{file_info.type}#{file_info.mode}",
        file_info.nlink.to_s.rjust(@max_nlink_length),
        file_info.owner.ljust(@max_owner_length),
        file_info.group.ljust(@max_group_length),
        file_info.size.to_s.rjust(4),
        file_info.mtime.strftime('%_m月 %d %H:%M'),
        file_info.name
      ].join(' ')
    end
  end

  def output_files_default
    rows = @files.size.ceildiv(COLUMN_SIZE)
    matrix_file_names = Array.new(rows) { Array.new(COLUMN_SIZE) }

    @files.each_with_index do |file, index|
      matrix_file_names[index.divmod(rows)[1]][index.divmod(rows)[0]] = file
    end

    col_max_lengths = Array.new(COLUMN_SIZE) do |col|
      matrix_file_names.map { |row| row[col].to_s.length }.max
    end

    matrix_file_names.each do |row|
      row.each_with_index do |file, col|
        print file.to_s.ljust(col_max_lengths[col] + 2)
      end
      puts
    end
  end

  def calc_max_length
    @max_nlink_length = @file_informations.map { |file| file.nlink.to_s.length }.max
    @max_owner_length = @file_informations.map { |file| file.owner.to_s.length }.max
    @max_group_length = @file_informations.map { |file| file.group.to_s.length }.max
  end
end
