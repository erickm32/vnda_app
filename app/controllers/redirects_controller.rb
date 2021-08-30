class RedirectsController < ApplicationController
  before_action :set_redirect, only: %i[show edit update destroy]
  before_action :create_sync_job_before_destroy, only: %i[destroy]
  after_action :create_sync_job, only: %i[create update]

  BASE_HEADERS = { 'Content-Type' => 'application/json', 'Accept' => 'application/json; version=1' }.freeze
  # BASE_API_URL = 'https://exemple.com/shops'.freeze
  BASE_API_URL = 'http://localhost:4567/shops'.freeze

  # GET /redirects or /redirects.json
  def index
    @redirects = Redirect.all
    @redirects_only_on_api = fetch_redirects_of_api
  end

  # GET /redirects/1 or /redirects/1.json
  def show; end

  # GET /redirects/new
  def new
    @redirect = Redirect.new
  end

  # GET /redirects/1/edit
  def edit; end

  # POST /redirects or /redirects.json
  def create
    @redirect = Redirect.new(redirect_params)

    respond_to do |format|
      if @redirect.save
        format.html { redirect_to @redirect, flash: { success: 'Redirect was successfully created.' } }
        format.json { render :show, status: :created, location: @redirect }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @redirect.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /redirects/1 or /redirects/1.json
  def update
    respond_to do |format|
      if @redirect.update(redirect_params)
        format.html { redirect_to @redirect, flash: { success: 'Redirect was successfully updated.' } }
        format.json { render :show, status: :ok, location: @redirect }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @redirect.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /redirects/1 or /redirects/1.json
  def destroy
    @redirect.destroy
    respond_to do |format|
      format.html { redirect_to redirects_url, flash: { success: 'Redirect was successfully destroyed.' } }
      format.json { head :no_content }
    end
  end

  def import_redirects_from_api
    if fetch_redirects_of_api.map(&:save).all?(true)
      redirect_to redirects_path, flash: { success: 'Successfully imported all redirects!' }
    else
      redirect_to redirects_path, flash: { error: 'Failed to save some redirect' }
    end
  end

  private

  def build_redirects(redirects, shop_remote_id)
    shop = Shop.find_by!(remote_id: shop_remote_id)
    redirects.map do |redirect|
      next unless shop.redirects.find_by(api_id: redirect['id'].to_i).nil?

      Redirect.new(
        api_id: redirect['id'].to_i,
        origin: redirect['path'],
        destination: redirect['redirect_to'],
        shop: shop
      )
    end
  end

  def create_sync_job_before_destroy
    return unless @redirect.persisted?

    @redirect.sync_jobs.create(operation: params[:action])
  end

  def create_sync_job
    return unless @redirect.persisted?

    @redirect.sync_jobs.create(params: redirect_params.to_json, operation: params[:action])
  end

  def fetch_redirects_of_api
    responses = Shop.pluck(:remote_id, :token).map do |shop_remote_id, token|
      url = "#{BASE_API_URL}/#{shop_remote_id}/redirects"
      [Faraday.get(url, nil, headers_with_authorization(token)), shop_remote_id]
    end
    responses.filter { |response, _shop_remote_id| response.status == 200 }
             .map { |response, shop_remote_id| [JSON.parse(response.body), shop_remote_id] }
             .map { |redirects, shop_remote_id| build_redirects(redirects, shop_remote_id) }
             .flatten
             .compact
  end

  def headers_with_authorization(token)
    BASE_HEADERS.merge({ 'Authorization' => "Token #{token}" })
  end

  # Only allow a list of trusted parameters through.
  def redirect_params
    params.require(:redirect).permit(:shop_id, :origin, :destination)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_redirect
    @redirect = Redirect.find(params[:id])
  end
end
