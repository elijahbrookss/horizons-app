class Api < ActiveRecord::Base

  def self.search(params="A")
    url = URI("https://deezerdevs-deezer.p.rapidapi.com/search?q=#{params}")
    results = self.get_search_results(self.setup(url))

    results
  end

  private

  def self.get_search_results(parsed_data)
    results = {}
    parsed_data["data"].each do |song|
      results[song["id"]] = {
        song_name: song["title"],
        preview: song["preview"],
        artist_name: song["artist"]["name"],
        album_picture: song["album"]["cover_big"],
        artist_picture: song["artist"]["picture"],
        album: song["album"]["title"],
        bpm: get_bpm(song["id"])
      }
    end
    results
  end

  def self.get_bpm(song_id)
    url = URI("https://deezerdevs-deezer.p.rapidapi.com/track/#{song_id}")
    parsed = self.setup(url)
    return parsed["bpm"]
  end


  ################ CONFIGURATIONS ################
  def self.setup(url)
    http = self.http(url)
    request = self.request(url)

    self.parse_data(http, request)
  end

  def self.http(url)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    http
  end

  def self.request(url)
    request = Net::HTTP::Get.new(url)
    request["x-rapidapi-key"] = '351f6c9ef8msh18168e44554dd42p1322a1jsn6df49a1ee6b3'
    request["x-rapidapi-host"] = 'deezerdevs-deezer.p.rapidapi.com'

    request
  end

  def self.parse_data(http, request)
    response = http.request(request)
    JSON.parse(response.body)
  end
end
