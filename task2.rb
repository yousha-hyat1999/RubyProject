$items = []
def read_file(filename)
  currItem = {}
  File.foreach(filename) do |line|
    line = line.strip
    category = line.match('smartphone|tablet|laptop|smartwatch', Regexp::IGNORECASE)
    currItem['category'] = category.to_s
    battery_life = line.match('[0-9]+hrs', Regexp::IGNORECASE)
    currItem['battery_life'] = battery_life.to_s
    model = line.match('\b((?=[A-Za-z/ -]{0,19}\d)[A-Za-z0-9/ -]{4,20})\b', Regexp::IGNORECASE)
    currItem['model'] = model.to_s
    manufacturer = line.match('apple|samsung|google|lenovo|lg', Regexp::IGNORECASE)
    currItem['manufacturer'] = manufacturer.to_s
    status = line.match('new|used|furbished', Regexp::IGNORECASE)
    currItem['status'] = status.to_s
    year = line.match('\d{4}$', Regexp::IGNORECASE)
    currItem['year'] = year.to_s
    price = line.match('\d+\$', Regexp::IGNORECASE)
    currItem['price'] = price.to_s
    features = line.match('{.*}', Regexp::IGNORECASE)
    currItem['feature'] = features.to_s
    color = line.match('white|black|blue|silver|burgundy',Regexp::IGNORECASE)
    currItem['color'] = color.to_s
    $items.push(currItem)
  end
end

def display_items
  $items.each do |item|
    puts "Category is :" + String(item['category'])
    puts "Battery Life is :" + String(item['battery_life'])
    puts "Model Number is :" + String(item['model'])
    puts "Color is :" + String(item['color'])
    puts "Manufacturer is :" + String(item['manufacturer'])
    puts "Status is :" + String(item['status'])
    puts "Year Built is :" + String(item['year'])
    puts "Price is :" + String(item['price'])
    puts "Features are :" + String(item['feature'])
  end
end


if ARGV.length != 1
  puts "Please Provide a File Name."
else
  if File.exist?(ARGV[0])
    read_file(ARGV[0])
    display_items
  else
    puts "File Does Not Exist Check Path Again."
  end
end