# encoding: utf-8
module Erp
  module Articles
    class ArticleUploader < CarrierWave::Uploader::Base
      # Include RMagick or MiniMagick support:
      # include CarrierWave::RMagick
      include CarrierWave::MiniMagick
      storage :file
      def store_dir
        "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
      end
      
      version :system do
        process resize_to_fill: [150, 150]
      end
      
      version :small do
        process resize_to_fill: [70, 70]
      end
      
      version :thumb270x175 do
				process :resize_and_pad => [270, 175, "#FFFFFF", "Center"]
			end
      
      version :medium do
        process resize_to_fill: [270, 175]
      end
    end
  end
end
