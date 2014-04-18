class HostsController < ApplicationController
  def index
    # Seems like this should not be used as the info will be in the DB
    # Maybe implement just to have an option to compare nagios to db
    render json: { host: @site.host_status( params[:host_id] ) }

  end

  def create
    doc = "
      define host {
        use linux-server  ; Name of host template to use
                          ; This host definition will inherit all variables that are defined
                          ; in (or inherited by) the linux-server host template definition.
           host_name      #{params[:name]}
           alias          #{params[:host_alias]}
           address        #{params[:address]}
      }"


    File.open("/usr/local/nagios/etc/objects/host_configs/#{params['name']}.cfg", 'w') {|f| f.write(doc) }
    restart_process
    params
  end

  def destroy

  end
end
