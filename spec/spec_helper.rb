require 'pry'
require 'rubygems'
require 'rspec'
require "selenium-webdriver"
require "selenium-client"
require "json"

Dir[File.dirname(__FILE__) + '/support/*.rb'      ].each { |f| require f }


RSpec.configure do |config|
  include Helpers
  include LeDriver
  config.before(:each) do
 	@base_url = "https://login.systemintegration.locaweb.com.br/"
 	driver.manage.window.maximize 
 	@accept_next_alert = true
 	driver.manage.timeouts.implicit_wait = 10
 	@verification_errors = []
  end
end