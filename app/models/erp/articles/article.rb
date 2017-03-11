module Erp::Articles
  class Article < ApplicationRecord
    belongs_to :creator, class_name: "Erp::User"
    belongs_to :category
    mount_uploader :image, Erp::Articles::ArticleUploader
    
    def self.search(params)
			if params[:cat_id].present?
				self.where(category_id: params[:cat_id])
			else
				self.all
			end
    end
    
    # data for dataselect ajax
    def self.dataselect(keyword='')
      query = self.all
      
      if keyword.present?
        keyword = keyword.strip.downcase
        query = query.where('LOWER(name) LIKE ?', "%#{keyword}%")
      end
      
      query = query.limit(8).map{|article| {value: article.id, text: article.name} }
    end
    
    def archive
			update_columns(archived: true)
		end
		
		def unarchive
			update_columns(archived: false)
		end
    
    def self.archive_all
			update_all(archived: true)
		end
    
    def self.unarchive_all
			update_all(archived: false)
		end
    
    def category_name
      category.present? ? category.name : ''
    end
    
    def post_by
			creator.present? ? creator.name : ''
		end
  end
end
