require 'rubygems'
require 'bundler/setup'
require './lib/deck.rb'
require './lib/template.rb'

test_deck = Deck.new
template = Template.new

test_deck.map(&template.method(:<<))

template.to_html
template.to_pdf