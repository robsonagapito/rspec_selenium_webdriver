#coding: utf-8

require 'spec_helper'

include RSpec::Expectations

describe "Sample test suite" do

  before(:each) do
    @driver = Selenium::WebDriver.for :firefox
    @base_url = "https://www.facebook.com/"
    @accept_next_alert = true
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
    @testSheet = DataDrivenTest.new
    @google = Google.new(@driver)
  end
  
  after(:each) do
    @driver.quit
    @verification_errors.should == []
  end
  
  it "Sample test", :test => true do
    @google.openGooglePage
  end

  it "DDT test", :test => true do
    sheet1 = @testSheet.readSheet('spec/support/ddt.xls',0)
    line = @testSheet.readLine(sheet1, 0)
    puts "linha =>" 
    puts line
    @testSheet.linha = 3
    @testSheet.coluna = 0
    row = @testSheet.readSelectionedCell(sheet1)
    puts "coluna =>" 
    puts row
    row = @testSheet.readColumn(sheet1,3,0)
    puts row
  end

  it "all login testadores.com", :test => true do
    sheet1 = @testSheet.readSheet('spec/support/ddt.xls','Login')
    sheet1.each do |row|
      @driver.get("http://testadores.com/")
      puts '    => CT - ' + row[0]
      @driver.find_element(:id, "modlgn_username").clear
      @driver.find_element(:id, "modlgn_username").send_keys row[1]
      @driver.find_element(:id, "modlgn_passwd").clear
      @driver.find_element(:id, "modlgn_passwd").send_keys row[2]
      @driver.find_element(:name, "Submit").click
      if element_present?(:xpath,"//dl[@id='system-message']/dd/ul/li") then
        (@driver.find_element(:xpath, "//dl[@id='system-message']/dd/ul/li").text).should == row[3]
      else
        (@driver.find_element(:css, "#form-login > div").text).should == row[3]
      end
    end
  end


  def element_present?(how, what)
    @driver.find_element(how, what)
    true
  rescue Selenium::WebDriver::Error::NoSuchElementError
    false
  end
  
  def alert_present?()
    @driver.switch_to.alert
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
end