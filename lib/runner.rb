#require "memori"
#require "delicious"
require "yaml"

class Memoritious::Runner
  attr_accessor :local, :memori, :delicious

  def initialize
    @local = false
    read_settings()
    setup()
  end
  
  def get_links
    @memori.parse()
    @memori.links
  end
  
  def post_links(links)
    links.each do |link|
      @delicious.post(link[:title], link[:url], link[:tags], link[:notes], link[:shared])
      #wait AT LEAST ONE SECOND between queries, or you are likely to get automatically throttled
      sleep 3
    end
  end
  
  def run
    post_links(get_links())
  end

  private
  def read_settings
    @settings = YAML::load(IO.read("settings.yml"))
  end
  
  def setup
    @memori = Memoritious::Memori.new(
      @settings["memori"]["login"],
      @settings["memori"]["password"]
    )
    @memori.local = @local
    
    @delicious = Memoritious::Delicious.new(
      @settings["delicious"]["login"],
      @settings["delicious"]["password"]
    )        
  end
end
