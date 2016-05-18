public class Audit_Trail{
	
	//PROPERTIES
	public Datetime date;
	public User user;
	public String action;
	public String detail;
	
	
	
	//GETTERS & SETTERS
	public List<SelectOption> getActions(){
		List<SelectOption> actions = new List<SelectOption>();
		actions.add(new SelectOption('LOGGEDIN','Logged In'));
		actions.add(new SelectOption('LOGGEDOUT','Logged Out'));
		actions.add(new SelectOption('VIEWEDRECORD','Viewed Record'));
		actions.add(new SelectOption('CREATEDRECORD','Created Record'));
		actions.add(new SelectOption('MODIFIEDRECORD','Modified Record'));
		actions.add(new SelectOption('DELETEDRECORD','Deleted Record'));
		actions.add(new SelectOption('COMPLETEDTASK','Completed Task'));
		actions.add(new SelectOption('LOGGEDCALL','Logged A Call'));
		return actions;
	}
	
	
	
	
}