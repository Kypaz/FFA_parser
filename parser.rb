require 'open-uri'
require 'nokogiri'
require 'watir'
require 'json'

#return a json with all pbs for a given athlete
def get_pb_athlete(id)
  base_url = "http://bases.athle.com/asp.net/athletes.aspx?"
  record = "base=records&seq="
  url = base_url+record+id

  browser = Watir::Browser.new
  browser.goto url
  doc = Nokogiri::HTML.parse(browser.html)

  res = []

  i = 2
  while doc.css(".linedRed table tr:nth-of-type("+i.to_s+")").text != ""
    row = {}
    event = doc.css(".linedRed table tr:nth-of-type("+i.to_s+") td[1]").text
    row["event"] = event
    result = doc.css(".linedRed table tr:nth-of-type("+i.to_s+") td[2]").text
    row["result"] = result
    location = doc.css(".linedRed table tr:nth-of-type("+i.to_s+") td[6]").text
    row["location"] = location
    date = doc.css(".linedRed table tr:nth-of-type("+i.to_s+") td[7]").text
    row["date"] = date
    row["show"] = true
    res.push(row)
    i = i +1
  end
  return res.to_json
end
