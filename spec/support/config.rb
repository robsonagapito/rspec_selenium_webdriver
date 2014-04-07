module LeDriver
  def driver
    @driver ||= begin
                  profile = Selenium::WebDriver::Firefox::Profile.new
                  profile.assume_untrusted_certificate_issuer = false
                  profile.secure_ssl = false
                  profile.native_events = true
                  profile['plugin.state.java'] = 10
                  #profile['browser.display.background_color'] = '#FFD700' 
                  caps = Selenium::WebDriver::Remote::Capabilities.firefox(:firefox_profile => profile)
                  caps.javascript_enabled = true
                  driver = Selenium::WebDriver.for :firefox, :profile => profile
                  #driver = Selenium::WebDriver.for(:remote, :url => "http://selenium.qaservices.locaweb.com.br/wd/hub", :desired_capabilities => caps)
                end
  end
end