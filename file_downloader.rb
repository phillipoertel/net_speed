require 'open-uri'

# WARNING: URLs can be very strange. This downloader only works reliably with images.
# see the TODO in file_extension, and the spec.
module Torial

  class FileDownloader

    class Error < StandardError; end

    class << self

      def download(url)
        url_file = open(url)
        outfile = Dir::Tmpname.make_tmpname(["/tmp/", file_extension(url, url_file.content_type)], nil)
        File.open(outfile, 'wb') { |file| file.write(url_file.read) }
        outfile
      rescue SocketError, OpenURI::HTTPError => e
        raise Error.new(e.message)
      end

      private

        def file_extension(url, url_content_type)

          matches = url.match(/\.([a-z]+)\Z/i)

          ext = if matches
            #
            # go for the standard pattern /path/to/some_image.jpg
            #
            matches[1]
          else
            #
            # if we don't get a proper extension, use the content_type the server reported.
            #
            # TODO extend test this for non-image types  
            tmp_ext = url_content_type.split('/').last
            tmp_ext == 'jpeg' ? 'jpg' : tmp_ext
          end
          ext ? ".#{ext}" : ""
        end

      end
  end
  
end