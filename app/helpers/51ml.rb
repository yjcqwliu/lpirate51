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
def if_is_app_user(attribute)
   ml = "<fo:if-is-app-user  "
   attribute.each do |key,value| 
      ml += "#{key}=\"#{value}\" "
   end
   ml += ">"
end

def end_if_is_app_user()
   ml = "</fo:if-is-app-user>"
end

def mlelse()
   ml = "<fo:else>"
end

def end_mlelse()
   ml = "</fo:else>"
end

def request_form(attribute)
    ml = "<fo:request-form  "
   attribute.each do |key,value| 
      ml += "#{key}=\"#{value}\" "
   end
   ml += "/>"
end

def end_request_form()
   ml = "</fo:request-form>"
end

def request_form_submit(attribute)
   ml = "<fo:request-form-submit "
   attribute.each do |key,value| 
      ml += "#{key}=\"#{value}\" "
   end
   ml += "/>"
end

def image(imgcase)
   ml = "<img src=\""
   case imgcase 
       when "dock"
	      ml += "http://p3.images22.51img1.com/6000/yjcqwlhm/3a28d388082fc6e94205b25446c8eeeb.jpg"
	   when "small_skull"
	      ml += "http://p7.images22.51img1.com/6000/yjcqwlhm/7071dc955ce3ad69eaf5e4fc3095ca71.jpg"
   end
   ml += "\" border=\"0\" >"
end
end