class NotificationsController < ApplicationController

#This method will display reminders when user click on See all
  def see_all_notify
    session[:notid]=nil
    @notifications=Notifications.where(:username => session[:uname])    
  end
 
 #This method will display notifications on user profile page
  def display
    @notifications_list = Notifications.select(:notify_string).where( :username => session[ :uname ]).map(&:notify_string).uniq
  end
  
  #Display edit notification
  def edit
    if session[:notid].nil?
      @notify_str=Notifications.find(params[:not_id].to_i)
      session[:notid]= params[:not_id].to_i
    else
      @notify_str=Notifications.find(session[:notid].to_i)
    end
 end

#This method will modify reminders when user click on Done and update into database
  def modify   
    notification=Notifications.find(session[:notid].to_i)
    notification.notify_string=params[:reminder]
    notification.date1=Date::civil(params[ :date_prefix ][ :year ].to_i, params[ :date_prefix ][ :month ].to_i, params[ :date_prefix ][ :day ].to_i)
    notification.save
    session[ :emsg ]="filled"
    redirect_to "/notifications/see_all_notify"
  end
#This method will delete reminders when user click on Delete
  def delete
    Notifications.find(params[:not_id].to_i).destroy
    session[ :emsg] = "deleted"
    redirect_to :back 
  end 
#This method will Add reminders when user click on Add reminder and Add into database
  def create
    if params[ :reminder ].blank?
      session[ :emsg ] = "empty type"
    else
     notification=Notifications.new( 
     notify_string: params[ :reminder ],
     date1: Date::civil(params[ :date_prefix ][ :year ].to_i, params[ :date_prefix ][ :month ].to_i, params[ :date_prefix ][ :day ].to_i),    
     username: session[ :uname ])
     notification.save
     session[ :emsg ]="filled"    
    end
    redirect_to "/notifications/see_all_notify"
  end
end
