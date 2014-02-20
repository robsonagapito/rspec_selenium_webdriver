require 'rubygems'
require 'rails/all'
require 'rspec'
require 'rspec/rails'

require File.dirname(__FILE__) + "/support/color_names.rb"
Dir[Rails.root.join('spec/support/*.rb')].each { |f| require f }