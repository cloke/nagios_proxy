class ServicesController < ApplicationController
  def index
    # Seems like this should not be used as the info will be in the DB
    # Maybe implement just to have an option to compare nagios to db
    
    services = @site.host_status( params[:host] )#.values

    render json: { services: services }

  end

  def create
    
    case params[:name]
    when 'http'
      write_http_service params[:host_name]
    when 'ping'
      write_ping_service params[:host_name]
    end
    params
  end

  def show
    @site.host_status params[:host_id]
  end

  protected

  def write_http_service host_name
    doc = "
      define service{
        use                             generic-service         ; Name of service template to use
        host_name                       #{host_name}
        service_description             HTTP
        check_command                   check_http
        notifications_enabled           0
        }
    "
    File.open("/usr/local/nagios/etc/objects/host_configs/#{host_name}_http_service.cfg", 'w') {|f| f.write(doc) }
  end

  def write_ping_service host_name
    doc = "
      define service{
        use                             generic-service         ; Name of service template to use
        host_name                       #{host_name}
        service_description             PING
        check_command                   check_ping
        notifications_enabled           0
        }
    "
    File.open("/usr/local/nagios/etc/objects/host_configs/#{host_name}_ping_service.cfg", 'w') {|f| f.write(doc) }
  end
end