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
end
