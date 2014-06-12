class Host < ActiveRecord::Base
  establish_connection :knewp_production

  include Nagios
  # field :name
  # field :host_alias
  # field :address
  # field :instance_active
  # field :instance_id

  def activate *params

    doc = "
      define host {
        use linux-server  ; Name of host template to use
                          ; This host definition will inherit all variables that are defined
                          ; in (or inherited by) the linux-server host template definition.
           host_name      #{name}
           alias          #{host_alias}
           address        #{address}
      }"


    File.open("/usr/local/nagios/etc/objects/host_configs/#{name}.cfg", 'w') {|f| f.write(doc) }
    restart
    update_attributes! instance_active: true
  end

  def destroy name
    File.delete "/usr/local/nagios/etc/objects/host_configs/#{params['id']}.cfg"
    render :nothing => true, :status => 204
  end
end