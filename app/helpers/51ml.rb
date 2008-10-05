class Ml
def name(attribute)
   ml = "<fo:name "
   attribute.each do |key,value| 
      ml += "#{key}=\"#{value}\" "
   end
   ml += "/>"
end
def userpic(attribute)
   ml = "<fo:profile-pic "
   attribute.each do |key,value| 
      ml += "#{key}=\"#{value}\" "
   end
   ml += "/>"
end
def image(imgcase)
   ml = "<img src=\""
   case imgcase 
       when "dock"
	      ml += "http://p2.images22.51img1.com/6000/yjcqwlhm/2d75b81956c993b1bc8637c1e52be5de.jpg"
	   when "small_skull"
	      ml += "http://p7.images22.51img1.com/6000/yjcqwlhm/7071dc955ce3ad69eaf5e4fc3095ca71.jpg"
   end
   ml += "\" border=\"0\" >"
end
end