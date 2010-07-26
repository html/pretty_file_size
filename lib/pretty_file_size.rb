# PrettyFileSize

module PrettyFileSize
  def pretty_file_size(size_in_bytes, options = {}, &block)
    names = {
      :b =>  " b",
      :kb => " Kb",
      :mb => " Mb",
      :gb => " Gb"
    }.merge(options[:names] || {})

    accuracy = options[:accuracy] || 2

    units = names.keys
    unit = units.shift

    size_in_bytes = size_in_bytes.to_f
    while (size_in_bytes / 1024) >= 1 do
      size_in_bytes = size_in_bytes / 1024
      unit = units.shift
    end

    if size_in_bytes.remainder(1).zero? || accuracy.zero?
      size_in_bytes = size_in_bytes.to_i
    else
      size_in_bytes = size_in_bytes - (size_in_bytes % (1.to_f / (10 ** accuracy)))
    end

    if block_given?
      yield size_in_bytes, names[unit]
    else
      size_in_bytes.to_s + names[unit]
    end
  end
end

ActionView::Base.send(:include, PrettyFileSize) if defined?(ActionView::Base)
