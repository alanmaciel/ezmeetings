class BuildingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_company
  before_action :set_building, only: [:show, :edit, :update, :destroy]

  def index
    @buildings = @company.buildings.all
  end

  def show
    @meeting_rooms = @building.meeting_rooms
  end

  def new
    @building = @company.buildings.build
  end

  def edit
    @building = @company.buildings.find(params[:id])
  end

  def create
    @building = @company.buildings.new(building_params)

    respond_to do |format|
      if @building.save
        format.html { redirect_to company_path(@company), notice: 'Building and Meeting Rooms were successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @building.update(building_params)
        format.html { redirect_to company_path(@company), notice: 'Building and Meeting Rooms were successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @building.destroy
    respond_to do |format|
      format.html { redirect_to company_path(@company), notice: 'Building was successfully destroyed.' }
    end
  end

  private
  def set_company
    @company = current_user.companies.find(params[:company_id])
  end

  def set_building
    @building = @company.buildings.find(params[:id])
  end

  def building_params
    params.require(:building).permit(
      :name,
      meeting_rooms_attributes: [:id, :name, :capacity, :_destroy,
                                 equipment_attributes: [:id, :_destroy, :name],
      equipment_meeting_rooms_attributes: [:id, :name, :_destroy, :equipment_id, equipment_attributes: [:id, :_destroy, :name]]]
    )
  end
end
