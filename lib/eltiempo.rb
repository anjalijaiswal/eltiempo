require 'eltiempo/version'
require 'nokogiri'
require 'net/http'
require 'json'

module Eltiempo
  class Error < StandardError; end
  Sample = Struct.new(:date, :temp_min, :temp_max, :humidity, :description)

  # Fetch city and weather details from Tiempo
  class TiempoApi
    def initialize(city, division = 102, api_lang = 'en')
      affiliate_id = ENV['ELTIEMPO_APP_ID'] || 'bc6wseo33f4j'
      get_city_url(city, affiliate_id, api_lang, division)
      # Default assignment in case city provided is invalid
      @city_url ||= "http://api.tiempo.com/index.php?api_lang=#{api_lang}&localidad=1200&affiliate_id=#{affiliate_id}&v=3.0"
    end

    # fetch todays temp
    def weather_today
      response = get_weather_data
      {
        date: response['day']['1']['date'],
        description: response['day']['1']['symbol_description'],
        min_temp: response['day']['1']['tempmin'],
        max_temp: response['day']['1']['tempmax']
      }
    end

    # fetch weekly maximum temperature
    def weekly_max_temp
      response = get_weather_data
      tempmax = response['day'].map { |num, day| day['tempmax'] }
      get_average(tempmax)
    rescue
      raise_error(e, 'max temperature of the week')
    end

    # fetch weekly minimum temperature
    def weekly_min_temp
      response = get_weather_data
      tempmin = response['day'].map { |num, day| day['tempmin'] }
      get_average(tempmin)
    rescue StandardError => e
      raise_error(e, 'min temperature of the week')
    end

    private

    def get_weather_data
      JSON.parse(Net::HTTP.get_response(URI.parse(@city_url)).body)
    rescue StandardError => e
      raise_error(e, 'the weather data')
    end

    def get_city_url(city, affiliate_id, lang, division)
      url_barcelona = "http://api.tiempo.com/index.php?api_lang=#{lang}&division=#{division}&affiliate_id=#{affiliate_id}"
      xml_body = Net::HTTP.get_response(URI.parse(url_barcelona)).body
      doc = Nokogiri::XML(xml_body)
      doc.xpath('//data').each do |data|
        if data.at_xpath('name').content.to_s.upcase == city.upcase
          @city_url = data.at_xpath('url').content.concat("&v=3.0&affiliate_id=#{affiliate_id}")

          break
        end
      end
    rescue StandardError => e
      raise_error(e, 'the city data')
    end

    def raise_error(err, error_msg)
      puts "...............ERROR #{err.message} ..................."
      raise "Something went wrong while fetching #{error_msg}, please try again in sometime"
    end

    def get_average(temps)
      (temps.map(&:to_i).inject { |avg_temp, temp| avg_temp + temp }.to_f / temps.size).round(2)
    end
  end
end
