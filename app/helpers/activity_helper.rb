module ActivityHelper

def activity_find(text,where,result,page)
    Activity.add_search(@user,text,where,result,page)
end

def activity_visit_item(item)

end

def activity_visit_group(group)

end

def activity_add_item(item, qty)

end

def activity_formed_order(order)

end

def activity_user
	current_user ? current_user.id : nil
end

def activity_save arg
	@activity ={}
	@activity['user_id'] = activity_user
	@activity['controller'] = arg[:controller]
	@activity['action'] = arg[:action]
	@activity['log'] = arg.except(:controller,:action)
	@activity['ip'] = request.remote_ip
	ActivityWorker.perform_async(@activity)
end

end
