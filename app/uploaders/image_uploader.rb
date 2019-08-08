class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  def store_dir
    if Rails.env.development? || Rails.env.test?
      "test/images/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    else
      "images/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url(*args)
    "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  end


  # Create different versions of your uploaded files:
  version :thumb do
    process resize_to_fit: [300, 300]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  def filename
    "#{Time.now.to_i}_#{original_filename}"
  end
end
