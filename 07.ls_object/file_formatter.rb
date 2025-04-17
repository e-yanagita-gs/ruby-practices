# frozen_string_literal: true

require_relative 'file_information'

class FileFormatter
  COLUMN_SIZE = 3

  def initialize(files, long_format: false)
    @long_format = long_format
    @file_informations = files.map { |file| FileInformation.new(file) }
  end

  def format
    if @long_format
      format_files_in_long_format
    else
      format_files_default
    end
  end

  private

  def format_files_in_long_format
    calc_max_length
    lines = @file_informations.map do |file_info|
      [
        "#{file_info.type}#{file_info.mode}",
        file_info.nlink.to_s.rjust(@max_nlink_length),
        file_info.owner.ljust(@max_owner_length),
        file_info.group.ljust(@max_group_length),
        file_info.size.to_s.rjust(4),
        file_info.mtime.strftime('%_m月 %d %H:%M'),
        file_info.name
      ].join(' ')
    end
    { total_blocks: @file_informations.map(&:block_size).sum, lines: lines }
  end

  def format_files_default
    file_names = @file_informations.map(&:name)
    rows = file_names.size.ceildiv(COLUMN_SIZE)
    matrix_file_names = Array.new(rows) { Array.new(COLUMN_SIZE) }

    file_names.each_with_index do |file_name, index|
      matrix_file_names[index.divmod(rows)[1]][index.divmod(rows)[0]] = file_name
    end

    col_max_lengths = Array.new(COLUMN_SIZE) do |col|
      matrix_file_names.map { |row| row[col].to_s.length }.max
    end

    { matrix_file_names: matrix_file_names, col_max_lengths: col_max_lengths }
  end

  def calc_max_length
    @max_nlink_length = @file_informations.map { |file| file.nlink.to_s.length }.max
    @max_owner_length = @file_informations.map { |file| file.owner.to_s.length }.max
    @max_group_length = @file_informations.map { |file| file.group.to_s.length }.max
  end
end
