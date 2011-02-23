require 'net/https'

module DeployTracking

  # Send data via a secure socket
  USE_SSL = true

  # The domain name of the deploytracking web app
  DEPLOY_TRACKING_HOST = 'deploytracking.heroku.com'

  # The relative end point of the service
  DEPLOY_TRACKING_PATH = '/deploys'

  # SSL port number that the service is available on
  DEPLOY_TRACKING_PORT = 443

  # Notify the deploytracking webservice of a new deployment
  # with a payload of data from capistrano.
  def self.notify(api_key, data)
    puts "[DeployTracking] Tracking Deployment to #{DEPLOY_TRACKING_HOST}"

    params = {'api_key' => api_key, 'deploy["gem_version"]' => DeployTracking::VERSION}
    data.each {|k,v| params["deploy[#{k}]"] = v }

    http = Net::HTTP.new(DEPLOY_TRACKING_HOST, DEPLOY_TRACKING_PORT)
    http.use_ssl = USE_SSL
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Post.new(DEPLOY_TRACKING_PATH)
    request.set_form_data(params)
    response = http.request(request)

    throw "[DeployTracking] Error posting to server." unless response.is_a?(Net::HTTPSuccess)
    puts "[DeployTracking] Deployment tracked"
    return response
  end
end