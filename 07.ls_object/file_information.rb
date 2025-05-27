# frozen_string_literal: true

require 'etc'

class FileInformation
  PERMISSION = {
    0 => '---',
    1 => '--x',
    2 => '-w-',
    3 => '-wx',
    4 => 'r--',
    5 => 'r-x',
    6 => 'rw-',
    7 => 'rwx'
  }.freeze

  def initialize(file)
    @file = file
    @stat = File.stat(file)
  end

  def block_size
    @stat.blocks / 2
  end

  def name
    @file
  end

  def type
    @stat.ftype == 'file' ? '-' : @stat.ftype[0]
  end

  def size
    @stat.size
  end

  def mode
    file_mode = format('%o', @stat.mode & 0o777).split('')
    file_mode.map { |digit| PERMISSION[digit.to_i] }.join
  end

  def nlink
    @stat.nlink
  end

  def owner
    Etc.getpwuid(@stat.uid).name
  end

  def group
    Etc.getgrgid(@stat.gid).name
  end

  def mtime
    @stat.mtime
  end
end
