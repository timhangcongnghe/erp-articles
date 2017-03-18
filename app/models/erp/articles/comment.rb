module Erp::Articles
  class Comment < ApplicationRecord
    validates :name, :email, :message, :presence => true
  end
end
