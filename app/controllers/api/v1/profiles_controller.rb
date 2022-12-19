class Api::V1::ProfilesController < ApplicationController
  before_action :authenticate_api_v1_user!
  before_action :set_profile, only: %i[show update]

  def index
    @profiles = Profile.all.includes(:user)
    render json: @profiles
  end

  def show
    @profile ||= Profile.create!(user_id: current_api_v1_user.id)
    render json: @profile
  end

  def update
    if @profile.save_with_tags(name: params.dig(:profile, :name).split(',').uniq)
      render json: @profile
    else
      render json: @profile.errors, status: :bad_request
    end

  private

  def set_profile
    @profile = Profile.find_by(user_id: current_api_v1_user.id)
  end

  def profile_params
    params.require(:profile).permit(:times_link, :commitment, :position, :motivation, :self_introduction, :phase, :grade, :editor)
  end
end
