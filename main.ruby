require 'nokogiri'
require 'open-uri'
require 'csv'

def scrape_oz_by(category_url, num_of_products)

  product_data = []

  # Output CSV file name
  filename = "output.csv"

  i = 0

  doc = Nokogiri::HTML(URI.open(category_url))
 
    while i < num_of_products
 
        product_name = doc.xpath('//div[@class="product-card__title"]')[i].text
        product_image_url = doc.xpath('//img[@class="product-card__cover-image"]/@src')[i]
        product_link = doc.xpath('//a[@class="link product-card__link"]/@href')[i]

        i += 1
        product_data << [product_name, product_image_url, product_link]
        
    end

  # Save product data to CSV file
  CSV.open(filename, 'w', encoding: 'Windows-1251') do |csv|
      csv << ['Product Name', 'Image URL', 'Product Link']
      product_data.each { |row| csv << row }
    end
 
end


category_url = 'https://oz.by/boardgames/'
num_of_products = 10
scrape_oz_by(category_url, num_of_products)