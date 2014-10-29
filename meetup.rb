require 'httparty'

class Meetup
  include HTTParty
  default_params key: ENV['MEETUP_API_KEY']
  base_uri 'https://api.meetup.com'

  def self.events
    get('/2/events', query: {
      text_format: 'plain',
      group_id: '17096822',
      status: 'upcoming',
      order: 'time'
    })['results']
    .map { |event| Event.new(event) } rescue []
  end

  class Event
    def initialize(data)
      @id    = data['id']          rescue ''
      @name  = data['name']        rescue ''
      @fee   = data['fee']         rescue ''
      @venue = data['venue']       rescue ''
      @time  = data['time']        rescue ''
      @url   = data['event_url']   rescue ''
      @desc  = data['description'] rescue ''
    end

    def id
      @id
    end

    def name
      @name
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

    def event_url
      @url
    end

    def photo_url
      'images/event.jpg'
    end
  end
end
