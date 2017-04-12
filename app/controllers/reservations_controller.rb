class ReservationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @buildings = Building.all
    return if params[:search].nil?
    @search_result = Reservation.search(params)

    unless @search_result.empty?
      @reservation = Reservation.new
      @begin_at = ("#{params[:search][:begin_at][:year]}-#{params[:search][:begin_at][:month]}-#{params[:search][:begin_at][:day]} 
                    #{params[:search][:begin_at][:hour]}:#{params[:search][:begin_at][:minute]}").to_datetime

      @ends_at = ("#{params[:search][:ends_at][:year]}-#{params[:search][:ends_at][:month]}-#{params[:search][:ends_at][:day]} 
                   #{params[:search][:ends_at][:hour]}:#{params[:search][:ends_at][:minute]}").to_datetime

      @building_id = params[:search][:building_id]
      @attendees = params[:search][:attendees]

      render :index and return
    end
    flash.now[:danger] = "No available meeting rooms found."
    render :index
  end

  def new
    @meeting_room = MeetingRoom.find(params[:reservation][:meeting_room_id])
    @begin_at = params[:begin_at]
    @ends_at = params[:ends_at]
    @building_id = params[:building_id]
    @attendees = params[:attendees]
    @reservation = @meeting_room.reservations.new(begin_at: @begin_at, ends_at: @ends_at)
  end

  def create
    meeting_room = MeetingRoom.find(params[:reservation][:meeting_room_id])
    @reservation = meeting_room.reservations.new(reservation_params)
    if @reservation.save
      flash[:success] = 'Reservation created'
      redirect_to @reservation
    else
      flash[:danger] = 'Reservation failed'
      render :new
    end
  end

  def show
    @reservation = Reservation.find(params[:id])
  end

  private

  def search_params
    params.require(:search).permit(:building_id, :capacity, :start_at, :ends_at)
  end

  def reservation_params
    params.require(:reservation).permit(:title, :begin_at, :ends_at, :meeting_room_id)
  end
end
