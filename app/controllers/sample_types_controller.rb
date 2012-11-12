class SampleTypesController < ApplicationController
  before_filter :require_user
  before_filter :set_nav_top
  layout "samples"

  def index
    @title = "Sample Types"
    @navinner = "1"
    @sample_types = SampleType.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sample_types }
    end
  end

  def show
    @sample_type = SampleType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sample_type }
    end
  end

  def new
    @title = "New Sample Type"
    @navinner = "2"
    @sample_type = SampleType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @sample_type }
    end
  end

  def edit
    @title = "Edit Sample Type"
    @navinner = "5"
    @sample_type = SampleType.find(params[:id])
  end

  def create
    @sample_type = SampleType.new(params[:sample_type])

    respond_to do |format|
      if @sample_type.save
        format.html { redirect_to sample_types_url, notive: 'Sample type was successfully created.' }
        format.json { render json: @sample_type, status: :created, location: @sample_type }
      else
        format.html { render action: "new" }
        format.json { render json: @sample_type.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @sample_type = SampleType.find(params[:id])

    respond_to do |format|
      if @sample_type.update_attributes(params[:sample_type])
        format.html { redirect_to sample_types_url, notice: 'Sample type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @sample_type.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @sample_type = SampleType.find(params[:id])
    @sample_type.destroy

    respond_to do |format|
      format.html { redirect_to sample_types_url }
      format.json { head :no_content }
    end
  end

  private
  
  def set_nav_top
    @navtop = "4"
  end

end
