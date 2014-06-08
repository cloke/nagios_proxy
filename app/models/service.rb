class Service  < ActiveRecord::Base
  establish_connection :knewp_production
  include Nagios

  def create params
    case params[:name].downcase
      when 'http'
        write_http_service params[:host_id]
      when 'ping'
        write_ping_service params[:host_id]
    end
    restart_process
    params
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
