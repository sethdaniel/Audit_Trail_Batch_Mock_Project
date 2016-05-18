global class Audit_Trails_Batch implements Database.Batchable<Audit_Trail>  {
	
	//INITIALIZE VARS
	global final String query;
	global Audit_Trails_Batch(String q){
		query = q;
	}



	//START
	global Database.QueryLocator start(Database.BatchableContext BC){
		return Database.getQueryLocator(query);
	}
	
	
	
	//EXECUTE
	global void execute(Database.BatchableContext BC, List<sObject> scope){
		
		//initialize vars
		List<Audit_Trail> toSaveAuditTrails = new List<Audit_Trail>();
		String opFlag = 'NONE';
		
		//determine object type
		SObjectType sObjectType = scope[0].getRecord().getSObjectType();
		
		for(SObject currentSobject: scope){
			
			//initialize vars
			Audit_Trail newAT = new Audit_Trail();
			
			//LoginHistory
			if(sObjectType == LoginHistory.sObjectType){
				
				//unclear to me that login history objects are inserted when user logs out so setting this to login only for now
				newAT.action = 'Logged In';
				newAT.date = currentSobject.get('LoginTime');
				newAT.user = User.getById(currentSobject.get('UserId'));//unverified pseudocode that did not cause an error in Eclipse
				newAT.detail = 'User log in.';
				
				//set flag
				opFlag = 'INSERT';
			}
			
			//Account or Contact
			else if(sObjectType == Account.sObjectType || sObjectType == Contact.sObjectType){
				
				//set flag
				opFlag = 'INSERT';
			}
			
		}
		
		//INSERT
		if(opFlag == 'INSERT'){
			insert toSaveAuditTrails;
		}
		
	}
	
	
	
	//FINISH
	global void finish(Database.BatchableContext BC){
		
	}


}