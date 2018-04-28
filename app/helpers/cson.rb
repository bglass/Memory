module CSON

  def load_file(fname)
    load_string File.read fname
  end

  def remove_indent(data)
    out = ""
    data.each_line do |line|
      out += line.sub /^\s\s/,""
    end
    out
  end

  def parse_array(data)
    data.gsub! /\n/, ","
    data.gsub! /([\[\{]),/, '\1'
    data.gsub! /,([\]\}])/, '\1'
    YAML.load data
  end

  def load_string(data)
    hashed = {}

    data.gsub! /^(\w+):\s+(\[.*?\])/mu do # find arrays
      key   =             Regexp.last_match[1]
      value = parse_array Regexp.last_match[2]
      hashed[key] = value
      ""
    end

    data.gsub! /(\w+):\s+\'\'\'\s*\n(.*?)\'\'\'/mu do # find heredocs
      hashed[Regexp.last_match[1]] = remove_indent Regexp.last_match[2]
      ""
    end
    hashed.merge YAML.load data
  end
end
