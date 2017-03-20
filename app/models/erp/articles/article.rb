module Erp::Articles
  class Article < ApplicationRecord
    belongs_to :creator, class_name: "Erp::User"
    belongs_to :category
    has_many :comments, class_name: "Erp::Articles::Comment"
    mount_uploader :image, Erp::Articles::ArticleUploader
    
    def self.search(params)
			self.all
		end
    
    def self.get_all_blogs(params)
			if params[:cat_id].present?
				query = self.where(category_id: params[:cat_id])
			else
				query = self.joins(:category).where('erp_articles_categories.alias = ?', Erp::Articles::Category::ALIAS_BLOG)
			end
			query = query.order('created_at DESC')
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
    
    # get newest articles
    def self.newest_articles(limit=nil)
			records = self.joins(:category).where("erp_articles_categories.alias = ?", Erp::Articles::Category::ALIAS_BLOG)
			records = records.limit(limit).order('created_at DESC')
			return records
		end
    
    # get terms and conditions
    def self.get_terms_and_conditions
			self.joins(:category).where("erp_articles_categories.alias = ?", Erp::Articles::Category::ALIAS_TERMS_CONDITIONS)
		end
    
    # get terms and conditions
    def self.get_faqs
			self.joins(:category).where("erp_articles_categories.alias = ?", Erp::Articles::Category::ALIAS_FAQ)
		end
  end
end
