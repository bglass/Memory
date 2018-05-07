class ZeitsController < ApplicationController
  before_action :set_zeit, only: [:show, :edit, :update, :destroy]



  def talk
  end


  # GET /zeits
  # GET /zeits.json
  def index
    @zeits = Zeit.all
  end

  # GET /zeits/1
  # GET /zeits/1.json
  def show
  end

  # GET /zeits/new
  def new
    @zeit = Zeit.new
  end

  # GET /zeits/1/edit
  def edit
  end

  # POST /zeits
  # POST /zeits.json
  def create
    @zeit = Zeit.new(zeit_params)

    respond_to do |format|
      if @zeit.save
        format.html { redirect_to @zeit, notice: 'Zeit was successfully created.' }
        format.json { render :show, status: :created, location: @zeit }
      else
        format.html { render :new }
        format.json { render json: @zeit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /zeits/1
  # PATCH/PUT /zeits/1.json
  def update
    respond_to do |format|
      if @zeit.update(zeit_params)
        format.html { redirect_to @zeit, notice: 'Zeit was successfully updated.' }
        format.json { render :show, status: :ok, location: @zeit }
      else
        format.html { render :edit }
        format.json { render json: @zeit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /zeits/1
  # DELETE /zeits/1.json
  def destroy
    @zeit.destroy
    respond_to do |format|
      format.html { redirect_to zeits_url, notice: 'Zeit was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_zeit
      @zeit = Zeit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def zeit_params
      params.fetch(:zeit, {})
    end
end
