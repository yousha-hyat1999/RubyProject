$words = []
$sentences = []
$sentences_in_paragraph_count =[]

def avg_word_size
  size = 0
  $words.each do |item|
    size =size + item.length
  end
  return Float(size / $words.length)
end

def avg_sentence_size
  size =0
  $sentences.each do |item|
    size =size +item
  end
  return Float(size/$sentences.length)
end

def avg_paragraph_size
  size =0;
  $sentences_in_paragraph_count.each do |item|
    size =size +item
  end
  return Float(size/$sentences_in_paragraph_count.length)
end

def char_count(data)
  count =0
  data.each_char{ |c|
    if c != " " and c != "\t" and c != "\n"
      count = count+1
    end
  }

  return count
end

def word_count(line)
  delimiters = [' ',',','!','?','.']
  data = line.split(Regexp.union(delimiters))
  data.delete("")
  data.delete("\n")
  data.delete("\t")
  $words.concat(data)
  return data.length

end

def sentence_count(line)
  delimiters = ['.', ';']
  data = line.split(Regexp.union(delimiters))
  data.delete("")
  data.delete("\n")
  data.delete("\t")
  $sentences.push(word_count(line))
  return data.length
end

def paragraph_count(filename)
  count = 0
  flag = false
  currCount = 0
  File.foreach(filename) do |line|
      if flag == true and line == "\n"
            count = count + 1
            $sentences_in_paragraph_count.push(currCount)
            currCount = 0
      else
        flag = false
        currCount = currCount + sentence_count(line)
      end
      if line == "\n"
        flag = true
      else
        currCount = currCount + sentence_count(line)
      end
  end
  return count
end

def read_file(filename)
  char_count =0
  word_count =0
  sentence_count =0
  paragraph_count =paragraph_count(filename)
  file =File.open(filename)
  size = file.size
  file.close
  line_count =0
  File.foreach(filename) do |line|
    char_count = char_count + char_count(line)
    word_count = word_count + word_count(line)
    sentence_count = sentence_count + sentence_count(line)
    line_count = line_count + 1
  end
  puts "Basic Statistics: "
  puts "Character Count: " + String(char_count)
  puts "Word Count: " + String(word_count)
  puts "Sentence Count: " + String(sentence_count)
  puts "Paragraph Count: " + String(paragraph_count)
  puts "Page Count: " + String(line_count/50)

  puts "Additional Statistics: "
  puts "Avg. Word Length: " + String(avg_word_size)
  puts "Avg. Sentence Length: " + String(avg_sentence_size)
  puts "Avg. Paragraph Length: " + String(avg_paragraph_size)
  puts "Avg. Paragraphs per page: " + String(Float(paragraph_count/(line_count/50)))
  puts "Char. Density: " + String(Float(char_count)/Float(size))
end

if ARGV.length != 1
  puts "Please Provide a File Name."
else
  if File.exist?(ARGV[0])
    read_file(ARGV[0])
  else
    puts "File Does Not Exist Check Path Again."
  end
end
