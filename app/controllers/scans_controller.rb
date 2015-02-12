class ScansController < ApplicationController
  before_action :set_scan, only: [:show, :update, :destroy]

  # GET /scans
  # GET /scans.json
  def index
    @scans = Scan.all

    render json: @scans
  end

  # GET /scans/1
  # GET /scans/1.json
  def show
    render json: @scan
  end

  # POST /scans
  # POST /scans.json
  def create
    @scan = Scan.new(scan_params)

    if @scan.save
      render json: @scan, status: :created, location: @scan
    else
      render json: @scan.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /scans/1
  # PATCH/PUT /scans/1.json
  def update
    @scan = Scan.find(params[:id])

    if @scan.update(scan_params)
      head :no_content
    else
      render json: @scan.errors, status: :unprocessable_entity
    end
  end

  # DELETE /scans/1
  # DELETE /scans/1.json
  def destroy
    @scan.destroy

    head :no_content
  end

  private

    def set_scan
      @scan = Scan.find(params[:id])
    end

    def scan_params
      params.require(:scan).permit(:name, :results)
    end
end
