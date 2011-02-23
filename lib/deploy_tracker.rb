require 'net/https'

module DeployTracker
  USE_SSL = true
  DEPLOY_TRACKING_HOST = 'deploytracking.heroku.com'
  DEPLOY_TRACKING_PATH = '/deploys'
  DEPLOY_TRACKING_PORT = 443

  def self.notify(api_key, data)
    puts "[DeployTracker] Tracking Deployment to #{DEPLOY_TRACKING_HOST}"

    params = {'api_key' => api_key}
    data.each {|k,v| params["deploy[#{k}]"] = v }

    http = Net::HTTP.new(DEPLOY_TRACKING_HOST, DEPLOY_TRACKING_PORT)
    http.use_ssl = USE_SSL
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Post.new(DEPLOY_TRACKING_PATH)
    request.set_form_data(params)
    response = http.request(request)

    throw "[DeployTracker] Error posting to server." unless response.is_a?(Net::HTTPSuccess)
    puts "[DeployTracker] Deployment tracked"
  end
end