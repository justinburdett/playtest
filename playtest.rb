#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'
require './lib/deck.rb'
require './lib/template.rb'

# Use the default OptionParser for CLI
require 'optparse'
options = {}
option_parser = OptionParser.new do |opts|

  # Switches
  opts.on("-v", "--verbose") do # Provide STDOUT output when cards are added
    options[:verbose] = true
  end
  
  # Flags
  opts.on("-f FORMAT", "--format FORMAT") do |format|
    format.downcase!
    unless %w(pdf html).include?(format)
      raise ArgumentError, "Format must be either 'pdf' or 'html', received #{format}"
    end
    options[:format] = format
  end
  opts.on("-c CARDS", "--cards CARDS") do |cards|
    unless File.exist?(cards)
      raise ArgumentError, "Could not find card source file: #{cards}"
    end
    options[:cards] = cards
  end
  opts.on("-s CSS", "--stylesheet CSS") do |css|
    unless File.exist?(css)
      raise ArgumentError, "Could not find stylesheet: #{css}"
    end
    options[:css] = css
  end
  opts.on("-h HTML", "--html HTML") do |html|
    options[:html] = html
  end
  opts.on("-o FILE", "--output FILE") do |file|
    unless File.writable?(dirname(file)) && (File.writable?(file) if File.exist?(file))
      raise ArgumentError, "Cannot write to #{file}"
    end
    options[:output] = file
  end
end

begin
  option_parser.parse!
rescue ArgumentError => e
  puts "Error: #{e}"
  exit(-1)
end

puts options.inspect

deck = Deck.new(options[:cards])
template = Template.new
deck.map(&template.method(:<<))

case options[:format]
  when "pdf"
    template.to_pdf
  when "html"
    template.to_html
end
