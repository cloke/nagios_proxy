class ApplicationController < ActionController::API
  
  def initialize
    # TODO Move this stuff to a config file. Should probably use localhost rather than ip.
    @cgi         = 'http://107.170.214.133/nagios/cgi-bin'
    @user        = 'nagiosadmin'
    @pass        = 'nagiosadmin'
    @version     = 4
    @time_format = 'us'
    @verify_ssl  = false

    @site = NagiosHarder::Site.new(@cgi, @user, @pass, @version, @time_format, @verify_ssl)
  end

  

end

