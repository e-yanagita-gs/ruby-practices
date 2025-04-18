# frozen_string_literal: true

require_relative 'file_information'

class FileFormatter
  COLUMN_SIZE = 3
  LongFormatResult = Data.define(:result, :total)
  DefaultFormatResult = Data.define(:result, :col_max_lengths)

  def initialize(files)
    @file_informations = files.map { |file| FileInformation.new(file) }
  end

  def long_format_with_total
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
    LongFormatResult.new(lines, @file_informations.map(&:block_size).sum)
  end

  def default_format_with_max_lengths
    file_names = @file_informations.map(&:name)
    rows = file_names.size.ceildiv(COLUMN_SIZE)
    matrix_file_names = Array.new(rows) { Array.new(COLUMN_SIZE) }

    file_names.each_with_index do |file_name, index|
      matrix_file_names[index.divmod(rows)[1]][index.divmod(rows)[0]] = file_name
    end

    col_max_lengths = Array.new(COLUMN_SIZE) do |col|
      matrix_file_names.map { |row| row[col].to_s.length }.max
    end
    DefaultFormatResult.new(matrix_file_names, col_max_lengths)
  end

  private

  def calc_max_length
    @max_nlink_length = @file_informations.map { |file| file.nlink.to_s.length }.max
    @max_owner_length = @file_informations.map { |file| file.owner.to_s.length }.max
    @max_group_length = @file_informations.map { |file| file.group.to_s.length }.max
  end
end
