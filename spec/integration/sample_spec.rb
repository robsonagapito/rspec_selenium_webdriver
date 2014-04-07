#coding: utf-8

require 'spec_helper'

include RSpec::Expectations

describe "Sample test suite" do

  before(:each) do
    @testSheet = DataDrivenTest.new
    @google = Google.new(@driver)
  end
  
  after(:each) do
    @driver.quit
    @verification_errors.should == []
  end
  
  it "Sample test", :test => true do
    @driver.get("http://google.com")
  end

  it "Sample test with class", :testA => true do
    @google._openGooglePage
  end

  it "DDT test", :testB => true do
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

  it "all login testadores.com", :testC => true do
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
end