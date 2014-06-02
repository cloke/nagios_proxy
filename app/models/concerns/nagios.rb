module Nagios
  extend ActiveSupport::Concern
  def restart
    `now=\`date +%s\`
     commandfile='/usr/local/nagios/var/rw/nagios.cmd'
     /usr/bin/printf "[%lu] RESTART_PROGRAM\n" $now > $commandfile
    `
  end
end