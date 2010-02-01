require "rubygems"
require "www/delicious"

module Memoritious
  class Delicious

    def initialize(login = nil, password = nil)
      @login = login and @password = password if login and password
    end
    
    def client
      @client ||= WWW::Delicious.new(@login, @password)
    end
    
    def recent
      client.posts_recent()
    end
    
    def post(title, url, tags=[], notes=nil, shared = true)
      begin
        client().posts_add(:url => url, :title => title, :tags => tags, :shared => shared)
      rescue WWW::Delicious::Error => e
        #There may be common error when we're posting link that already exists,
        #just skip it
      end
    end
  end
end