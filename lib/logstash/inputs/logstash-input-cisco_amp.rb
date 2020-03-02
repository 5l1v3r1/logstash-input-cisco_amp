# encoding: utf-8
require "logstash/inputs/base"
require "logstash/namespace"
require "stud/interval"
require 'net/http'
require 'uri'
require 'time'
require 'json'

class LogStash::Inputs::CiscoAMP < LogStash::Inputs::Base
  config_name "logstash-input-cisco_amp"
  default :codec, "json"

  config :id, :validate => :string

  config :key, :validate => :string

  config :interval, :validate => :number, :default => 1

  public
  def register
    @interval = @interval * 60
  end

  def run(queue)
    while !stop?

      current_datetime = Time.now.utc - (@interval)
      iso8601date = current_datetime.iso8601
      events_uri = "https://api.amp.cisco.com/v1/events?start_date=" + iso8601date

      uri = URI.parse(events_uri)
      request = Net::HTTP::Get.new(uri)
      request.content_type = "application/json"
      request["Accept"] = "application/json"
      request.basic_auth @id,@key

      req_options = {
        use_ssl: uri.scheme == "https",
      }

      response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
        http.request(request)
      end

      data = JSON.parse(response.body)

      if data.has_key?("data")
        data['data'].each do |child|
          event = LogStash::Event.new("message" => child.to_json)
          decorate(event)
          queue << event
        end
      end

      Stud.stoppable_sleep(@interval) { stop? }
    end # loop
  end # def run

  def stop
  end
end # class LogStash::Inputs::Example