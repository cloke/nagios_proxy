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

  def restart_process
   # Use Nagiosharder to exec this command (need to implement in harder)
    `now=\`date +%s\`
     commandfile='/usr/local/nagios/var/rw/nagios.cmd'
     /usr/bin/printf "[%lu] RESTART_PROGRAM\n" $now > $commandfile
    `
  end

end
