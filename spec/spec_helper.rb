require 'rubygems'
require 'rspec'
require "selenium-webdriver"
require "selenium-client"
require "json"

Dir[File.dirname(__FILE__) + '/support/*.rb'].each { |f| require f }