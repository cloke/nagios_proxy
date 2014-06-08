class ServicesController < ApplicationController
  def index
    # Seems like this should not be used as the info will be in the DB
    # Maybe implement just to have an option to compare nagios to db
    
    # Using host_id as that is how the route submits.
    services = @site.host_status( params[:host_id] )#.values
    render json: { services: services }
  end

  def show
    # This currently returns all services. Need to figure out how to limit to one.
    services = @site.host_status params[:host_id]
    render json: { services: services }

  end

  def destroy
    # File.delete "/usr/local/nagios/etc/objects/host_configs/#{params[:host_id]}_#{params[:id].downcase}_service.cfg"
    restart_process
    render :nothing => true, :status => 204
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
        check_command                   check_ping!100.0,20%!500.0,60%
        notifications_enabled           0
        }
    "
    File.open("/usr/local/nagios/etc/objects/host_configs/#{host_name}_ping_service.cfg", 'w') {|f| f.write(doc) }
  end
end