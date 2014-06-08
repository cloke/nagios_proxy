class Host < ActiveRecord::Base
  establish_connection :knewp_production

  include Nagios

  def create params
    doc = "
      define host {
        use linux-server  ; Name of host template to use
                          ; This host definition will inherit all variables that are defined
                          ; in (or inherited by) the linux-server host template definition.
           host_name      #{params['name']}
           alias          #{params['host_alias']}
           address        #{params['address']}
      }"


    File.open("/usr/local/nagios/etc/objects/host_configs/#{params['name']}.cfg", 'w') {|f| f.write(doc) }
    restart
    params
  end

  def destroy name
    File.delete "/usr/local/nagios/etc/objects/host_configs/#{params['id']}.cfg"
    render :nothing => true, :status => 204
  end
end