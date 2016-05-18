global class Audit_Trail_Scheduler implements Schedulable {
	
	//initialize vars
	Datetime nowDt = Datetime.now();
	Datetime startOfDayDt = datetime(today.year, today.month, today.day, tzinfo=tz.tzutc());
	Integer userId = UserInfo.getUserId();
	
	global void execute(SchedulableContext ctx) {
		
		String query = [SELECT Status, LoginTime from LoginHistory WHERE LoginTime <: nowDt AND LoginTime >: startOfDayDt AND UserId = : userId];
		
		Audit_Trails_Batch myBatch = new Audit_Trails_Batch(query);
		Database.executeBatch(myBatch);
		
	}
	
}