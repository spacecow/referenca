class Article < ActiveRecord::Base
  has_many :references, :dependent => :destroy
  has_many :referenced_articles, :through => :references
  accepts_nested_attributes_for :references, :reject_if => lambda {|a| a[:referenced_article_id].blank?}, :allow_destroy => true
  
  has_many :authorships, :dependent => :destroy
  has_many :authors, :through => :authorships
  accepts_nested_attributes_for :authorships, :reject_if => lambda {|a| a[:author_id].blank?}, :allow_destroy => true

  has_many :articles_keywords, :dependent => :destroy
  has_many :keywords, :through => :articles_keywords
  accepts_nested_attributes_for :articles_keywords, :reject_if => lambda {|a| a[:keyword_id].blank?}, :allow_destroy => true

  belongs_to :group
  belongs_to :owner, :class_name => "User"
  
  attr_accessible :title, :authorships_attributes, :references_attributes, :articles_keywords_attributes, :summarize, :journal, :volume, :start_page, :end_page, :paper, :year, :no
  
  mount_uploader :pdf, PdfUploader

  validates :title, :presence => true, :uniqueness => true
  validates :year, :presence => true
  validates :owner, :presence => true
  validates :group, :presence => true

  scope :reference_order, lambda{order("authors.last_name asc").order("year desc").includes(:authors)}
  
  def authors_and_year_for_filename
    authors_and_year_for_long_reference.gsub(/[,\s]/,'_')
  end
  def authors_and_year_for_long_reference
    (authors_for_long_reference+", ").sub(/, /," (#{year}) ").chop.sub(/,$/,'')
  end

  def authors_for_long_reference
    authors.map{|e| "#{e.first_name} #{e.last_name}"}.join(', ')
  end
  
  def authors_for_short_reference
    ret = authorships.map(&:author).map(&:last_name).join(' and ')
    if authors.size == 3
      ret.sub!(" and",",") if authors.size == 3
    elsif authors.size >=3
      ret.sub!(/ and .*/," et al")
    end
    ret
  end
  def authors_straight; authors.map(&:straight_name).join(", ") end

  def extension; pdf.url.split('.').last end
  
  def file?; !no_file? end
  def filename
    "#{authors_and_year_for_filename}_-_#{title_for_filename}.#{extension}"
  end
  
  def first_author
    return "" if authors.empty?
    authors.first.last_name
  end

  def group_assoc(assoc); group end

  def no_empty?; no.nil? || no.empty? end  
  def no_file?; pdf.url.nil? end

  def owner_assoc(assoc); owner end
  
  def reference; "#{authors_for_short_reference} (#{year}) - #{title}".truncate(60) end

  def pdf_name; pdf.path.split('/').last end

  def private_assoc(assoc); private() end
  
  def self.search(search,sort)
    if search
      if sort.split('", "').size > 1
        sorts = sort[2..-3].split('", "')
        search_string = sorts.map{|e| "authors.#{e} LIKE ?"}.join(' or ')
        where(search_string, *sorts.size.times.map{|e| "%#{search}%"}).includes(:authors)
      elsif sort == "keywords.name"
        where("#{sort} LIKE ?", "%#{search}%").includes(:keywords)
      else
        where("#{sort} LIKE ?", "%#{search}%")
      end
    else
      scoped
    end
  end

  def title_for_filename; title.gsub(/[,\s]/,'_') end
  
  def volume_empty?; volume.nil? || volume.empty? end
end
