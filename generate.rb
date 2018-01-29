require 'json'

def oauth_token
  ENV['OAUTH_TOKEN']
end

def generate_url(year, month)
  month_with_leading_zero = month <= 9 ? "0#{month}" : month
  "curl -s -H \"Authorization: Bearer #{oauth_token}\" https://api.fitbit.com/1/user/-/body/log/weight/date/#{year}-#{month_with_leading_zero}-01/1m.json"
end

def download_part(year, month)
  url = generate_url(year, month)
  json = JSON.parse(`#{url}`)
  json["weight"]
end

def write_year(year, data)
  File.write("data/#{year}.json", JSON.pretty_generate(data))
  puts "Year #{year} downloaded to data/#{year}.json"
end

def download_all
  years.map do |year|
    data = ((1..12).map do |month|
      download_part(year, month) if year < 2018 || month < 3
    end).compact.flatten
    write_year(year, data)
  end
end

def combine_all
  combined = (years.map do |year|
    JSON.parse(File.read("data/#{year}.json"))
  end).flatten
  File.write('data/combined.json', JSON.pretty_generate(combined))
end

def years
  (2013..2018)
end

download_all
combine_all
