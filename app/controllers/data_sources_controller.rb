class DataSourcesController < ApplicationController
  before_action :set_data_source, only: %i[ show update destroy ]

  # GET /data_sources
  # GET /data_sources.json
  def index
    @data_sources = @current_user.data_sources
  end

  # GET /data_sources/1
  # GET /data_sources/1.json
  def show
  end

  # POST /data_sources
  # POST /data_sources.json
  def create
    data_source = DataSource.new(data_source_params.merge({ user_id: @current_user.id }))

    if data_source.save
      render json: { data_source: data_source }, status: :created
    else
      render json: data_source.errors.full_messages, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /data_sources/1
  # PATCH/PUT /data_sources/1.json
  def update
    if @data_source.update(data_source_params)
      render json: { message: 'Updated!' }, status: :created
    else
      render json: @data_source.errors.full_messages, status: :unprocessable_entity
    end
  end

  # DELETE /data_sources/1
  # DELETE /data_sources/1.json
  def destroy
    @data_source.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_data_source
      @data_source = DataSource.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def data_source_params
      params.require(:data_source).permit!
    end
end
