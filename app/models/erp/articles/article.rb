module Erp::Articles
  class Article < ApplicationRecord
    belongs_to :creator, class_name: "Erp::User"
    belongs_to :category
    has_many :comments, class_name: "Erp::Articles::Comment", dependent: :destroy
    mount_uploader :image, Erp::Articles::ArticleUploader
    
    def self.search(params)
			self.all
		end
    
    # get articles active
    def self.get_active
			self.where(archived: false).order("created_at DESC")
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
    
    def category_id
      category.present? ? category.id : ''
    end
    
    def category_name
      category.present? ? category.name : ''
    end
    
    def post_by
			creator.present? ? creator.name : ''
		end
    
    # get all blogs
    def self.get_all_blogs(params)
			query = self.get_active
			if params[:cat_id].present?
				query = query.where(category_id: params[:cat_id])
			else
				query = query.joins(:category).where('erp_articles_categories.alias = ?', Erp::Articles::Category::ALIAS_BLOG)
			end
			query = query.order('created_at DESC')
    end
    
    # get newest articles
    def self.newest_articles(limit=nil)
			records = self.get_active.order('created_at DESC')
			records = records.joins(:category).where("erp_articles_categories.alias = ?", Erp::Articles::Category::ALIAS_BLOG).limit(limit)
		end
    
    # get terms and conditions
    def self.get_terms_and_conditions
			self.joins(:category).where("erp_articles_categories.alias = ?", Erp::Articles::Category::ALIAS_TERMS_CONDITIONS)
		end
    
    # get terms and conditions
    def self.get_faqs
			self.joins(:category).where("erp_articles_categories.alias = ?", Erp::Articles::Category::ALIAS_FAQ)
		end
    
    # get tags
    def get_tags
			tags.to_s.split(/[\,\;]/).select {|c| c.present? }
		end
  end
end
