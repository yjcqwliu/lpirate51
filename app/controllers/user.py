import cgi
import os
from google.appengine.ext.webapp import template
from google.appengine.api import users
from google.appengine.ext import webapp
from google.appengine.ext.webapp.util import run_wsgi_app
from google.appengine.ext import db


class UserPage(webapp.RequestHandler):
    def get(self):
        template_values = {}
        path = os.path.join(os.path.dirname(__file__), 'login.html')
        self.response.out.write(template.render(path, template_values))
    def post(self):
        user = Users()
        username = cgi.escape(self.request.get('username'))
        password = cgi.escape(self.request.get('password'))
        user.gql("where username = :1 ",username)
        if user:
            if user.password == password:
                #login in
                self.redirect('/')
            else:
                #password error
                template_values = {
                    'error':'password error'
                    }
                path = os.path.join(os.path.dirname(__file__), 'login.html')
                self.response.out.write(template.render(path, template_values))
        else:
            user.username = username
            user.password = password
            user.put
        
                
                
        
        
        
        
        
        
