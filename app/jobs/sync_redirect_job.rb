class SyncRedirectJob < ApplicationJob
  queue_as :default
  # BASE_URL = 'https://exemple.com/shops'.freeze
  BASE_URL = 'http://localhost:4567/shops'.freeze
  BASE_HEADERS = { 'Content-Type' => 'application/json', 'Accept' => 'application/json; version=1' }.freeze

  def perform(*args)
    redirect = args[0]
    last_job = redirect.sync_jobs.last
    return if last_job.nil?

    call_specific_action_on_external_api(redirect, last_job) if last_job.waiting?
  end

  # rubocop:disable Metrics/MethodLength
  def call_specific_action_on_external_api(redirect, last_job)
    last_job.update(status: :processing)
    case last_job.operation
    when 'create'
      create_redirect_on_api(redirect, last_job)
    when 'update'
      update_redirect_on_api(redirect, last_job) if redirect.api_id.present?
    when 'destroy'
      destroy_redirect_on_api(redirect, last_job) if redirect.api_id.present?
    else
      last_job.update(status: :failed)
      raise StandardError(message: 'Something is not right')
    end
  end
  # rubocop:enable Metrics/MethodLength

  def create_redirect_on_api(redirect, last_job)
    url = "#{BASE_URL}/#{redirect.shop.remote_id}/redirects"
    response = Faraday.post(url, last_job.params, headers_with_authorization(redirect.shop.token))
    if response.status == 201
      redirect.update(api_id: JSON.parse(response.body)['id'])
      last_job.update(status: :success)
    else
      last_job.update(status: :failed)
    end
  end

  def destroy_redirect_on_api(redirect, last_job)
    url = "#{BASE_URL}/#{redirect.shop.remote_id}/redirects/#{redirect.api_id}"
    response = Faraday.delete(url, nil, headers_with_authorization(redirect.shop.token))
    if response.status == 204
      last_job.update(status: :success)
    else
      last_job.update(status: :failed)
    end
  end

  def update_redirect_on_api(redirect, last_job)
    url = "#{BASE_URL}/#{redirect.shop.remote_id}/redirects/#{redirect.api_id}"
    response = Faraday.patch(url, last_job.params, headers_with_authorization(redirect.shop.token))
    if response.status == 200
      last_job.update(status: :success)
    else
      last_job.update(status: :failed)
    end
  end

  def headers_with_authorization(token)
    BASE_HEADERS.merge({ 'Authorization' => "Token #{token}" })
  end
end
