require File.dirname(__FILE__) + '/../generic/helpers.rb'

Dir[File.dirname(__FILE__) + '/../generic/color_name.rb'].each { |f| require f }
Dir[File.dirname(__FILE__) + '/../generic/*.rb'].each { |f| require f }
Dir[File.dirname(__FILE__) + '/class/*.rb'].each { |f| require f }

module LeDriver
  def driver
    @driver ||= begin
                  profile = Selenium::WebDriver::Firefox::Profile.new
                  profile.assume_untrusted_certificate_issuer = false
                  profile.secure_ssl = false
                  profile.native_events = true
                  vDir = File.dirname(__FILE__) + '/../../generic'
                  # profile['plugin.state.java'] = 10
                  # profile['browser.display.background_color'] = '#FFD7000'

                  # caps guarda informações para o selenium grid se for utilizar.
                  # caps = Selenium::WebDriver::Remote::Capabilities.firefox(:firefox_profile => profile)
                  # caps = Selenium::WebDriver::Remote::Capabilities.chrome
                  # caps.javascript_enabled = true
                  # caps.platform = "Linux"

                  # executa o browse na máquina local
                  driver = Selenium::WebDriver.for :firefox, profile: profile
                  # executa o browse na máquina remota - SeleniumGrid
                  # driver = Selenium::WebDriver.for(:remote, :url => "http://selenium.grid.com.br/wd/hub", :desired_capabilities => caps)
                end
  end
end

RSpec.configure do |config|
  include Helpers
  include LeDriver
  include Screenshot

  config.before(:each) do
    @base_url = ''
    driver.manage.window.maximize
    @accept_next_alert = true
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
  end

  config.after(:each) do
    screenshot_error(example, @driver, '')
    @driver.quit
    @verification_errors.should == []
  end
end
