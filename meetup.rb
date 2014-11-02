require 'httparty'

class Meetup
  include HTTParty
  default_params key: ENV['MEETUP_API_KEY']
  base_uri 'https://api.meetup.com'

  def self.photos
    get('/2/photos', query: {
      photo_album_id: '24630942',
      group_id: '17096822'
    })['results'] rescue []
  end

  def self.events
    get('/2/events', query: {
      text_format: 'plain',
      group_id: '17096822',
      status: 'upcoming',
      order: 'time'
    })['results'] rescue []
  end

  def self.events_with_photos
    begin
      photos_lut = photos.inject({}) do |lut, data|
        photo = Photo.new(data)
        lut[photo.caption] = photo unless photo.caption.nil?
        lut
      end

      events.map do |data|
        event = Event.new(data)
        event.photo = photos_lut[event.id]
        event
      end
    rescue
      []
    end
  end

  class Photo
    attr_reader :id, :url, :caption

    def initialize(data)
      @id      = data['photo_id']   rescue ''
      @url     = data['photo_link'] rescue ''
      @caption = data['caption']    rescue ''
    end
  end

  class Event
    attr_accessor :photo
    attr_reader   :id, :name, :url

    def initialize(data)
      @id    = data['id']          rescue ''
      @name  = data['name']        rescue ''
      @fee   = data['fee']         rescue ''
      @venue = data['venue']       rescue ''
      @time  = data['time']        rescue ''
      @url   = data['event_url']   rescue ''
      @desc  = data['description'] rescue ''
    end

    def fee
      "£#{'%.2f' % @fee['amount']}" rescue ''
    end

    def venue
      @venue['name'] rescue ''
    end

    def date
      Time.at(@time/1000).strftime("%e %b %Y") rescue ''
    end

    def description
      @desc.match(/.{0,75}\b/)[0] << '...' rescue ''
    end

    def photo_url
      @photo.url rescue 'images/event.png'
    end
  end
end
