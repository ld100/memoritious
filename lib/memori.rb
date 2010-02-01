require "rubygems"
require "nokogiri"
require 'net/http'

module Memoritious
  class Memori
    attr_accessor :links, :login, :password, :local
  
    def initialize(login = nil, password = nil)
      @links = Array.new
      @local = true
      @login = login and @password = password if login and password
    end
    
    def get_remote_content
      Net::HTTP.start("memori.ru", 80) do |http|
         req = Net::HTTP::Get.new("/api-v2/posts/all")
         req.basic_auth(@login, @password)
         response = http.request(req)
         response.body
       end
    end
  
    def parse
      #@input = Nokogiri::XML(File.new("memori.xml")) if local
      @input = Nokogiri::XML(File.new(File.join("data", "memori.xml"))) if local
      @input = Nokogiri::XML(get_remote_content) unless local
      @input.xpath('/posts/post').each do |post|
        shared = true
        shared = false if post["share"] == "no"
        
        item = { :title => post["name"],
          :notes => post["description"],
          :url => post["href"],
          :time => post["time"],
          :shared => shared,
          :tags => post["tag"].split(",").map {|tag| tag.strip }
        }
        @links.push(item)
      end
    end
  end
end