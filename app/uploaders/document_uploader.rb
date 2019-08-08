class DocumentUploader < CarrierWave::Uploader::Base
  def store_dir
    if Rails.env.development? || Rails.env.test?
      "test/images/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    else
      "images/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end
  end

  def filename
    "#{Time.now.to_i}_#{original_filename}"
  end

  def extension_whitelist
    %w(jpg jpeg png pdf doc docx odt ppt pptx xlsx xls txt)
  end

end
