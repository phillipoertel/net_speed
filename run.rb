require 'logger'
require_relative 'file_downloader'
url = 'https://androidnetworktester.googlecode.com/files/1mb.txt'

logger = Logger.new('duration.log')
logger.level = Logger::INFO

INTERVAL = 60

def measure
  start = Time.now
  yield
  Time.now - start
end

loop do
  duration = measure { Torial::FileDownloader.download(url) }
  log_string = "#{Time.now}: #{duration}"
  if duration > 3
    1.times { `afplay /System/Library/Sounds/Blow.aiff` }
  end
  puts log_string
  logger.info(log_string)
  sleep INTERVAL
end

