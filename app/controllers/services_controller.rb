require_relative './../../lib/internal_crud_services/internal_crud_libs/services/service_obj.rb'

class ServicesController < AuthenticationController

  include InternalCrudServices::InternalCrudLibs::Services

  def create
    render json: ServiceObj.new(create_params).create.record.as_json, status: 201
  end

  def update
    render json: ServiceObj.new(update_params).update.as_json, status: 201
  end

  def get_object
    render json: ServiceObj.new({id: params[:id]}).record, status: 200
  end

  def get_list
    render json: ServiceObj.get_list, status: 200
  end

  private

  def create_params
    cleanup_params(require_params(:services).permit(:name, :is_mobile_or_web_or_both))
  end

  def update_params
    cleanup_params(require_params(:services).permit(:name, :is_mobile_or_web_or_both, :is_web_published, :is_app_published)).merge!({
      id: params["id"]
    })
  end

end
