class MembersController < ApplicationController
  before_action :set_member, only: %i[show update destroy] 

  # GET /members
  def index
    @members = Member.all

    render json: @members, only: %i[name band_id]
  end

  # POST /members
  def create
    @member = Member.new(member_params)
    @member.band_id = params[:band_id]

    if @member.save
      render json: @member, status: :created
    else
      render json: {errors: @member.errors}, status: :unprocessable_entity
    end
  end

  # GET /members/1
  def show
      render json: @member
  end

  # PUT /members/1
  def update
    if @member.update(member_params)
      render json: @member, status: :ok
    else
      render json: {errors: @member.errors}, status: :unprocessable_entity
    end
  end

  # DELETE /members/1
  def destroy
    if @member.destroy
      render json: {message: "Resource deleted"}, status: :ok
    else
      render json: {errors: @member.errors}, status: :unprocessable_entity
    end
  end

  private

  # Only allow a list of trusted parameters through
  def member_params
    params.require(:member).permit(:name, :band_id)
  end

  def set_member
    @member = Member.find(params[:id])
  end
end
