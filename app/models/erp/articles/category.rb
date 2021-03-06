module Erp::Articles
  class Category < ApplicationRecord
    include Erp::CustomOrder
		
    belongs_to :creator, class_name: "Erp::User"
    belongs_to :parent, class_name: "Erp::Articles::Category", optional: true
    has_many :children, class_name: "Erp::Articles::Category", foreign_key: "parent_id"
    has_many :articles, class_name: "Erp::Articles::Article"
    validates :name, :presence => true
    
    # class const
    ALIAS_COOPERATIVE_CUSTOMERS = 'cooperative_customers'
    ALIAS_HOME_ABOUT = 'home_about'
    ALIAS_SERVICE = 'service'
    ALIAS_IDENTITY = 'identity'
    ALIAS_ABOUT_US = 'about_us'
    ALIAS_CAREER = 'career'
    ALIAS_BLOG = 'blog'
    ALIAS_FAQ = 'faq'
    ALIAS_TERMS_CONDITIONS = 'terms_conditions'
    ALIAS_WARRANTY = 'warranty'
    ALIAS_PAYMENT = 'payment'
    ALIAS_DELIVERY = 'delivery'
    ALIAS_RETURN_REFUND = 'return_refund'
    ALIAS_SECURITY = 'security'
    ALIAS_SHOPPING_GUIDE = 'shopping_guide'
    ALIAS_OPERATING_REGULATIONS = 'operating_regulations'
    ALIAS_POLICY_GROUP = [ALIAS_WARRANTY, ALIAS_PAYMENT, ALIAS_DELIVERY, ALIAS_RETURN_REFUND, ALIAS_SECURITY, ALIAS_SHOPPING_GUIDE, ALIAS_OPERATING_REGULATIONS]
    
    # get alias for contact
    def self.get_alias_options()
      [
        {text: I18n.t('blog'),value: self::ALIAS_BLOG},
        {text: I18n.t('faq'),value: self::ALIAS_FAQ},
        {text: I18n.t('warranty'),value: self::ALIAS_WARRANTY},
        {text: I18n.t('payment'),value: self::ALIAS_PAYMENT},
        {text: I18n.t('delivery'),value: self::ALIAS_DELIVERY},
        {text: I18n.t('return_refund'),value: self::ALIAS_RETURN_REFUND},
        {text: I18n.t('security'),value: self::ALIAS_SECURITY},
        {text: I18n.t('terms_conditions'),value: self::ALIAS_TERMS_CONDITIONS},
        {text: I18n.t('shopping_guide'),value: self::ALIAS_SHOPPING_GUIDE},
        {text: I18n.t('operating_regulations'),value: self::ALIAS_OPERATING_REGULATIONS}
      ]
    end
    
    # get categories active
    def self.get_active
			self.where(archived: false)
		end
    
    # Filters
    def self.filter(query, params)
      params = params.to_unsafe_hash
      and_conds = []
      
      # show archived items condition - default: false
			show_archived = false
			
			#filters
			if params["filters"].present?
				params["filters"].each do |ft|
					or_conds = []
					ft[1].each do |cond|
						# in case filter is show archived
						if cond[1]["name"] == 'show_archived'
							# show archived items
							show_archived = true
						else
							or_conds << "#{cond[1]["name"]} = '#{cond[1]["value"]}'"
						end
					end
					and_conds << '('+or_conds.join(' OR ')+')' if !or_conds.empty?
				end
			end
      
      #keywords
      if params["keywords"].present?
        params["keywords"].each do |kw|
          or_conds = []
          kw[1].each do |cond|
            or_conds << "LOWER(#{cond[1]["name"]}) LIKE '%#{cond[1]["value"].downcase.strip}%'"
          end
          and_conds << '('+or_conds.join(' OR ')+')'
        end
      end
      
      # join with users table for search creator
      query = query.joins("LEFT JOIN erp_articles_categories parents_erp_articles_categories ON parents_erp_articles_categories.id = erp_articles_categories.parent_id")
      
      # showing archived items if show_archived is not true
			query = query.where(archived: false) if show_archived == false

      query = query.where(and_conds.join(' AND ')) if !and_conds.empty?
      
      # global filter
      global_filter = params[:global_filter]

      if global_filter.present?

				# filter by alias
				if global_filter[:alias].present?
					query = query.where(alias: global_filter[:alias])
				end

			end
      # end// global filter
      
      return query
    end
    
    def self.search(params)
      query = self.all
      query = self.filter(query, params)
      
      # order
      if params[:sort_by].present?
        order = params[:sort_by]
        order += " #{params[:sort_direction]}" if params[:sort_direction].present?
        
        query = query.order(order)
      end
      
      return query
    end
    
    # data for dataselect ajax
    def self.dataselect(keyword='')
      query = self.all
      
      if keyword.present?
        keyword = keyword.strip.downcase
        query = query.where('LOWER(name) LIKE ?', "%#{keyword}%")
      end
      
      query = query.limit(20).map{|category| {value: category.id, text: category.name} }
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
    
    # display name
    def parent_name
			parent.present? ? parent.name : ''
		end
		
		# display name with parent
    def full_name
			names = [self.name]
			p = self.parent
			while !p.nil? do
				names << p.name
				p = p.parent
			end
			names.reverse.join(" / ")
		end
    
    #
    def self.get_categories_by_alias_group
			self.where(alias: Erp::Articles::Category::ALIAS_POLICY_GROUP)
		end
    
    def self.get_categories_by_alias_blog
			query = self.get_active
			query = query.where(alias: Erp::Articles::Category::ALIAS_BLOG)
		end
  end
end
