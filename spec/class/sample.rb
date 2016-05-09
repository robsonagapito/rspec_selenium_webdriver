# coding: utf-8

# include RSpec::Expectations

class Google < ColorNames
  attr_accessor :driver

  def initialize(data)
    self.driver = data
  end

  def openGooglePage
    @driver.get('http://google.com')
  end

  def searchValue(value)
  	@driver.find_element(:id, 'lst-ib').clear
    @driver.find_element(:id, 'lst-ib').send_keys value
    @driver.find_element(:name, 'btnG').click
  end

  def result
    res = @driver.find_element(:id, 'resultStats').text
    res.match('.[012346789]\.[0123456789]{3}').to_s.delete('.').to_i
  end 
end
