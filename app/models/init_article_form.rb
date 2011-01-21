module InitArticleForm
  private
    def create_empty_authorship(no=1); no.times{@article.authorships.build} end
    def create_empty_keyword(no=1); no.times{@article.articles_keywords.build} end
    def create_empty_reference(no=1); no.times{@article.references.build} end
    def init_form(no=1,exception=nil)
      load_author unless exception == :author
      load_authors
      load_keywords
      load_keyword unless exception == :keyword
      create_empty_authorship(no)
      create_empty_keyword(no)
    end
    def init_rendered_form(no=1,exception=nil)
      init_form(no,exception)
      create_empty_reference
      load_articles   
    end
    def load_articles
      @articles = Article.all.
        reject{|e| e==@article}.
        sort_by_author_first_name_then_year.
        map{|e| [e.reference, e.id]}
    end
    def load_keywords
      @keywords = Keyword.order('name asc').
        map{|e| [e.name, e.id]}
    end
    def load_author; @author = Author.new end
    def load_authors; @authors = Author.order('last_name ASC').map{|e| [e.reversed_name, e.id]} end
    def load_keyword; @keyword = Keyword.new end
end
