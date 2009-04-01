# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  require "pp"
  helper :all # include all helpers, all the time
  
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  #protect_from_forgery # :secret => '7982602486defa6700eb432a7a0095d7'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
     
  #require  "platform/#{platform}.rb"
  acts_as_wuyao_controller
  before_filter :set_current_user
  def set_current_user
		  if @current_user.nil?
        #pp "------#{wuyao_session.inspect}---"
        @current_user = SnsUser.find_or_create_by_xid(wuyao_session.user)
        if @current_user.session_key != wuyao_session.session_key
          @current_user.session_key = wuyao_session.session_key

        end
        update_friend_ids
        @current_user.friend_ids_will_change!
        @current_user.save
        
      end
      
  end
  def update_friend_ids
			if (@current_user.friend_ids.blank? or @current_user.friend_ids.type == String) or @current_user.updated_at < Time.now - 8.hour
					#pp "-----use friend api--@current_user.friend_ids.type:#{@current_user.friend_ids.type}-"
					res = wuyao_session.invoke_method("wuyao.friends.get")
					if res.kind_of? Wuyao::Error
					  @current_user.friend_ids = [] if @current_user.friend_ids.blank?
					else
						hashres = []
						res.each do |h|
							hashres << h.uid
						end
					    @current_user.friend_ids = hashres
					end
			else
					#pp "----don't-use friend api--@current_user.friend_ids.type:#{@current_user.friend_ids.type}-"
			end
	end
  
  def current_user
    @current_user
  end
  
  def xn_redirect_to(to_url,feilds={})
    path = "#{to_url}?"
        feilds.each do |key,value|
	     path += "#{key}=#{URI.escape(value)}&"
        end
    render :text => "<fo:redirect url=\"\/#{ENV['WUYAO_RELATIVE_URL_ROOT']}\/#{path}\"/>"
  end

end
