CarrierWave.configure do |config|
  if Rails.env.development? || Rails.env.test?
    config.storage = :file
  else
    config.storage    = :aws
    config.aws_bucket = ENV['aws_bucket']
    # public reads are disabled for images
    # config.aws_acl    = 'public-read'

    # The maximum period for authenticated_urls is only 7 days.
    config.aws_authenticated_url_expiration = 60 * 60 * 24 * 7

    # Set custom options such as cache control to leverage browser caching
    config.aws_attributes = {
      expires: 1.week.from_now.httpdate,
      cache_control: 'max-age=604800'
    }

    config.aws_credentials = {
      access_key_id:     ENV["aws_id"],
      secret_access_key: ENV["aws_key"],
      region:            ENV["aws_zone"]
    }
  end
end
