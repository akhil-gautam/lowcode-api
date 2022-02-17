class FormsController < ApplicationController
  before_action :set_form, only: %i[ show update destroy exec_query form_elements]
  skip_before_action :authorize_request, only: [:show, :form_elements, :exec_query]

  # GET /forms
  # GET /forms.json
  def index
    @forms = Form.all
  end

  def form_elements
    if @form.draft? && @current_user.nil?
      raise UnauthorizedError
    end
    @form_elements = @form.form_elements.order(:field_order)
  end

  # GET /forms/1
  # GET /forms/1.json
  def show
    if @form.draft? && @current_user.nil?
      raise UnauthorizedError
    end
  end

  def exec_query
    if @form.draft? && @current_user.nil?
      raise UnauthorizedError
    end
    outcome = FormQuery.run({ data_source: @form.data_source, form: @form, form_data: exec_params })
    if outcome.valid?
      render json: { result: outcome.result }, status: :ok
    else
      render json: { errors: outcome.errors },
              status: :unprocessable_entity
    end
  end

  # POST /forms
  # POST /forms.json
  def create
    @form = Form.new(form_params)

    if @form.save
      render json: {message: 'Success!'}, status: :ok
    else
      render json: @form.errors.full_messages, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /forms/1
  # PATCH/PUT /forms/1.json
  def update
    if @form.update(form_params)
      render json: @form, status: :ok
    else
      render json: @form.errors.full_messages, status: :unprocessable_entity
    end
  end

  # DELETE /forms/1
  # DELETE /forms/1.json
  def destroy
    @form.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_form
      @form = Form.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def form_params
      params.require(:form).permit(:title, :app_id, :status, :form_query)
    end

    def exec_params
      params.permit(@form.form_elements.pluck(:db_column).map(&:to_sym))
    end
end
