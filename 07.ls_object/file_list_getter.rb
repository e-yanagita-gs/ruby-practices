# frozen_string_literal: true

class FileListGetter
  def initialize(show_all: false, reverse: false)
    @show_all = show_all
    @reverse = reverse
  end

  def list_files
    flags = @show_all ? File::FNM_DOTMATCH : 0
    @reverse ? Dir.glob('*', flags).reverse : Dir.glob('*', flags)
  end
end
