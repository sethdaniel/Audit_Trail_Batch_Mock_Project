global class Audit_Trails_Cleanup implements Schedulable {
	
	//INITIALIZE VARS
	public static String cron = '0 0 0 7 * ? *';//runs every month on day 7
	List<Audit_Trail> toDelete = new List<Audit_Trail>();
	
	//DATETIMES FOR PREVIOUS MONTH
	//LAST DAY OF PREVIOUS MONTH
	Date todayDate = Date.today();
	Date lastDayOfPreviousMonth = todayDate.addDays(-8);
	Time endOfDay = Time.newInstance(23, 59, 59, 0);
	Datetime lastDayOfPreviousMonthDt = Datetime.newInstance(lastDayOfPreviousMonth, endOfDay);
	
	//FIRST DAY OF PREVIOUS MONTH
	Date firstDayOfCurrentMonth = todayDate.addDays(-7);
	Date firstDayOfPreviousMonth = firstDayOfCurrentMonth.addMonths(-1);
	Time startOfDay = Time.newInstance(0, 0, 0, 0);
	Datetime firstDayOfPreviousMonthDt = Datetime.newInstance(firstDayOfPreviousMonth,startOfDay);
	
	

	//HELPER METHOD
	global static String scheduleThis(){
		Audit_Trails_Cleanup myAuditTrailsCleanup = new Audit_Trails_Cleanup();
		return System.schedule('Monthly Audit Trails Cleanup', cron, myAuditTrailsCleanup);
	}
	
	//EXECUTE
	global void execute(SchedulableContext sc) {
		
		for(Audit_Trail currentAt : [SELECT id, date, user, action, detail FROM Audit_Trail WHERE date >: firstDayOfPreviousMonthDt AND date <: lastDayOfPreviousMonthDt]){
			
			toDelete.add(currentAt);
			
		}
		
		delete toDelete;
		
	}
	
}