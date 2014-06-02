class Service
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
end
