# coding: utf-8

require 'spec_helper'

include RSpec::Expectations

describe 'Sample test suite' do
  before(:each) do
    @testSheet = DataDrivenTest.new
    @google = Google.new(@driver)
  end

  after(:each) do
  end

  it 'Sample test', test: true do
    @driver.get('http://google.com')
  end

  it 'is searching Robson Agapito in google page', test: true do
    @google.__openGooglePage
    @google.__searchValue('Robson Agapito')
    expect(@google.result).to be_between(78000, 79000)
  end

  it 'DDT test - reading XLS file by line x column', testB: true do
    sheet1 = @testSheet.readSheet('spec/support/ddt.xls', 0)
    line = @testSheet.readLine(sheet1, 0)
    puts 'linha =>'
    puts line
    @testSheet.linha = 3
    @testSheet.coluna = 0
    row = @testSheet.readSelectionedCell(sheet1)
    puts 'coluna =>'
    puts row
    row = @testSheet.readColumn(sheet1, 3, 0)
    puts row
  end

  it 'all login testadores.com', testC: true do
    sheet1 = @testSheet.readSheet('spec/support/ddt.xls', 'Login')
    sheet1.each do |row|
      @driver.get('http://www.vagas.com.br/')
      puts '    => CT - ' + row[0]
      @driver.find_element(:id, 'btLogin').click

      @driver.find_element(:id, 'IdentCand').clear
      @driver.find_element(:id, 'IdentCand').send_keys row[1]
      @driver.find_element(:id, 'SenhaCand').clear
      @driver.find_element(:id, 'SenhaCand').send_keys row[2]
      @driver.find_element(:name, 'botInfContinua').click
      if element_present?(:id, "PrTtitE")
        expect(@driver.find_element(:id, "PrTtitE").text).to eq(row[3])
      else
        expect(@driver.find_element(:css, 'b').text).to eq(row[3])
      end
    end
  end
end
