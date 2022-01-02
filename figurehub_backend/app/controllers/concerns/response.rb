module Response
  def json_response(object, status = :ok)
    render json: object, status: status
  end

  def json_response_without_time(object, status = :ok)
    render json: object.as_json(except: [:created_at, :updated_at]), status: status
  end
end