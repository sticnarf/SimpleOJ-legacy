# encoding: utf-8

class DataFileUploader < CarrierWave::Uploader::Base
  storage :postgresql_lo
end
