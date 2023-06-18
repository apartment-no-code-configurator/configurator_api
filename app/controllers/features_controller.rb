require_relative './../../lib/internal_crud_services/internal_crud_libs/features/feature_obj.rb'

class FeaturesController < AuthenticationController

  include InternalCrudServices::InternalCrudLibs::Features

  attr_accessor :feature_record

  def create
    @feature_record = FeatureObj.new(create_params).create.record
    render json: feature_record.as_json, status: 201
  end

  def update
    @feature_record = FeatureObj.new(update_params).update.record
    render json: feature_record.as_json, status: 201
  end

  def get_object
    render json: FeatureObj.new({}, params[:id]).get_object, status: 200
  end

  def get_list
    render json: FeatureObj.get_list, status: 200
  end

  private

  def create_params
    cleanup_params(require_params(:features).permit(:name, :service_id))
  end

  def update_params
    cleanup_params(require_params(:features).permit(:id, :name, :service_id, :is_published)).merge!({
      id: params["id"]
    })
  end

end
