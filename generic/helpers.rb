require 'pry'
require 'rubygems'
require 'rspec'
require "selenium-webdriver"
require "selenium-client"
require "json"
require 'open-uri'
require 'openssl'
require 'yaml'
require File.dirname(__FILE__) + '/color_name.rb'

module Helpers

  def decode(value, replace)
    value.gsub!("***", replace)
  end

  def element_present?(how, what)
    driver.find_element(how, what)
    true
  rescue Selenium::WebDriver::Error::NoSuchElementError
    false
  end 
  
  def alert_present?()
    driver.switch_to.alert
    true
  rescue Selenium::WebDriver::Error::NoAlertPresentError
    false
  end
  
  def verify(&blk)
    yield
  rescue ExpectationNotMetError => ex
    @verification_errors << ex
  end
  
  def close_alert_and_get_its_text(how, what)
    alert = @driver.switch_to().alert()
    alert_text = alert.text
    if (@accept_next_alert) then
      alert.accept()
    else
      alert.dismiss()
    end
    alert_text
  ensure
    @accept_next_alert = true
  end

    def set_field_value(value, selector)
    element = get_element(selector)
    
    element.clear
    element.send_keys value
  end

  def wait_for(selector)
    !60.times{ break if (get_element(selector).text rescue false); sleep 1 }
  end

  def click(selector)
    element = get_element(selector)

    element.click
  end

  def get_element(selector)
    @driver.find_element(selector)
  end

  def navigate_to(url)
    @driver.get(url)
  end
  
end

