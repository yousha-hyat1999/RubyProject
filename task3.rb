$items = []
$unsaved_items = []
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

def add_item(line)
  currItem = {}
  line = line.strip
  category = line.match('smartphone|tablet|laptop|smartwatch', Regexp::IGNORECASE)
  if category == nil
    puts "Category was not entered in input."
    return
  end
  currItem['category'] = category.to_s
  battery_life = line.match('[0-9]+hrs', Regexp::IGNORECASE)
  if battery_life == nil
    puts "Battery Life was not entered in input."
    return
  end
  currItem['battery_life'] = battery_life.to_s
  model = line.match('\b((?=[A-Za-z/ -]{0,19}\d)[A-Za-z0-9/ -]{4,20})\b', Regexp::IGNORECASE)
  if model == nil
    puts "Model was not entered in input."
    return
  end
  currItem['model'] = model.to_s
  manufacturer = line.match('apple|samsung|google|lenovo|lg', Regexp::IGNORECASE)
  if manufacturer == nil
    puts "Manufacturer was not entered in input."
    return
  end
  currItem['manufacturer'] = manufacturer.to_s
  status = line.match('new|used|furbished', Regexp::IGNORECASE)
  if status == nil
    puts "Status was not entered in input."
    return
  end
  currItem['status'] = status.to_s
  year = line.match('\d{4}$', Regexp::IGNORECASE)
  if year == nil
    puts "Year was not entered in input."
    return
  end
  currItem['year'] = year.to_s
  price = line.match('\d+\$', Regexp::IGNORECASE)
  if price == nil
    puts "Price was not entered in input."
    return
  end
  currItem['price'] = price.to_s
  features = line.match('{.*}', Regexp::IGNORECASE)
  if features == nil
    puts "Features were not entered in input."
    return
  end
  currItem['feature'] = features.to_s
  color = line.match('white|black|blue|silver|burgundy',Regexp::IGNORECASE)
  if color == nil
    puts "Color was not entered in input."
    return
  end
  currItem['color'] = color.to_s
  $unsaved_items.push(currItem)
  puts "Item Added."
end

def display_items(chunk)
  chunk.each do |item|
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

def write_file(name)
  file = File.open(name, 'w')
  $unsaved_items.each do |item|
      file.write(String(item['category'])+",")
      file.write(String(item['battery_life'])+",")
      file.write(String(item['model'])+",")
      file.write(String(item['color'])+",")
      file.write(String(item['manufacturer'])+",")
      file.write(String(item['status'])+",")
      file.write(String(item['year'])+",")
      file.write(String(item['price'])+",")
      file.write(String(item['feature']))
      file.write("\n")
  end
  file.close
end

def display_menu
  puts "1: Display Listing"
  puts "2: Import Listing"
  puts "3: Export Listing"
  puts "4: Add Listing"
  puts "5: Exit"
end


  while true
    display_menu
    puts "Enter your choice: "
    input = gets
    begin
      choice = Integer(input)
    rescue
      puts "Invalid Number. Please try again."
      next
    end
    if choice == 1
      if $items.length == 0 and $unsaved_items.length ==0
        puts "Nothing to display."
        next
      end
      display_items($items)
      display_items($unsaved_items)
    elsif  choice ==2
      puts "Enter File Name:"
      name = gets.chomp
      if File.exist?(name)
        read_file(name)
        puts "Import Complete."
      else
        puts "File Does not Exists!"
      end
    elsif  choice ==3
      puts "Enter File Name:"
      name = gets.chomp
      write_file(name)
    elsif  choice ==4
      puts "Please Enter all required (9) attributes comma separated"
      line = gets
      add_item(line)
    elsif  choice ==5
      puts "Exiting Program"
      break
    else
      puts "Invalid choice. Please try again."
    end
  end