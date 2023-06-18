require_relative './../../lib/internal_crud_services/internal_crud_libs/mandatory_apps/mandatory_app_obj.rb'

class MandatoryAppsController < AuthenticationController

  include InternalCrudServices::InternalCrudLibs::MandatoryApps

  attr_accessor :mandatory_app_record

  def create
    @mandatory_app_record = MandatoryAppObj.new(create_params).create.record
    render json: mandatory_app_record.as_json, status: 201
  end

  def update
    @mandatory_app_record = MandatoryAppObj.new(update_params).update.record
    render json: mandatory_app_record.as_json, status: 201
  end

  def get_object
    render json: MandatoryAppObj.new({id: params[:id]}).record, status: 200
  end

  def get_list
    render json: MandatoryAppObj.get_list, status: 200
  end

  private

  def create_params
    cleanup_params(require_params(:mandatory_apps).permit(:name, :is_public, :service_id))
  end

  def update_params
    cleanup_params(require_params(:mandatory_apps).permit(:id, :name, :is_public, :service_id, :is_published)).merge!({
      id: params["id"]
    })
  end

end
