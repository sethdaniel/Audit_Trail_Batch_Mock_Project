public class Pixel_Controller{
	
	//returns a list of tracked objects (Accounts & Contacts) for the visualforce page to list
	//this assumes that the value of the pageBlockTable is set to {!trackedobjects}
	public List<Display_Tracked_Object> getTrackedObjects(){
		
		//initialize vars
		//get all accounts
		DescribeSObjectResult accountDescribeResult = Account.getSObjectType().getDescribe();
		List<String> accountFieldNames = new List<String>( accountDescribeResult.fields.getMap().keySet() );
		String accountQuery = ' SELECT ' + String.join( accountFieldNames, ',' ) + ' FROM ' + accountDescribeResult.getName();
		List<SObject> allAccounts = new List<SObject>(accountQuery);

		//get all contacts
		DescribeSObjectResult contactDescribeResult = Contact.getSObjectType().getDescribe();
		List<String> contactFieldNames = new List<String>( contactDescribeResult.fields.getMap().keySet() );
		String contactQuery = ' SELECT ' + String.join( contactFieldNames, ',' ) + ' FROM ' + contactDescribeResult.getName();
		List<SObject> allContacts = new List<SObject>(contactQuery);
		
		//get master list of sobjects
		List<SObject> trackedsobjects = new List<SObject>();
		trackedsobjects.addAll(allAccounts);
		trackedsobjects.addAll(allContacts);
		
		//get master list of displayable objects
		List<Display_Tracked_Object> trackedobjects = new List<Display_Tracked_Object>();
		for(SObject currentTrackedSobject : trackedsobjects){
			
			//initialize vars
			SObjectType currentTrackedObjType = currentTrackedSobject.getRecord().getSObjectType();
			String objTypeName = 'Account';
			String objLabel = currentTrackedSobject.get('Name');
			if(currentTrackedObjType == Contact.sObjectType){
				objTypeName = 'Contact';
			}
			
			Display_Tracked_Object myDisplayTrackedObject = new Display_Tracked_Object();
			myDisplayTrackedObject.name = objLabel;
			myDisplayTrackedObject.objType = objTypeName;
			myDisplayTrackedObject.myObject = currentTrackedSobject;
			
			trackedobjects.add(myDisplayTrackedObject);
			
			
		}
		
		return trackedobjects;
		
	}
	
	
	//provide variables for visualforce display per tracked object 
	public class Display_Tracked_Object{
		
		//PROPERTIES
		public String name;
		public String objType;
		public SObject myObject;
		
		
	}
	
}