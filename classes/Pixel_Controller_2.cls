public class Pixel_Controller_2{

	//This class is called anytime the nested view "pixel" is opened. "pixel" is embedded in both Account and Contact views
	
	//INITIALIZE VARS
	//get type either Account or Contact
	String objTypeName = ApexPages.currentPage().getParameters().get('type');//what is param name to get type???

	//ACCOUNT
	if(objTypeName == 'Account'){
		
		DescribeSObjectResult accountDescribeResult = Account.getSObjectType().getDescribe();
		List<String> accountFieldNames = new List<String>( accountDescribeResult.fields.getMap().keySet() );
		String accountQuery = ' SELECT ' + String.join( accountFieldNames, ',' ) + 
							  ' FROM ' + accountDescribeResult.getName() + 
							  ' WHERE id = ' + ApexPages.currentPage().getParameters().get('id');
		
		Account thisAccount = new Account(accountQuery);
		
		Audit_Trail thisAuditTrail = new Audit_Trail();
		thisAuditTrail.date = Datetime.now();
		thisAuditTrail.user = User.getById(UserInfo.getUserId());
		thisAuditTrail.action = 'Viewed Record';
		thisAuditTrail.detail = 'User viewed Account ' + thisAccount.Name;
		
		insert thisAuditTrail;
	}
	
	//CONTACT
	else{
		
		DescribeSObjectResult contactDescribeResult = Contact.getSObjectType().getDescribe();
		List<String> contactFieldNames = new List<String>( contactDescribeResult.fields.getMap().keySet() );
		String contactQuery = ' SELECT ' + String.join( contactFieldNames, ',' ) + 
							  ' FROM ' + contactDescribeResult.getName() + 
							  ' WHERE id = ' + ApexPages.currentPage().getParameters().get('id');
		
		Contact thisContact = new Contact(contactQuery);
		
		String firstName = '';
		String spaceName = '';
		if(!isEmpty(thisContact.FirstName)){
			firstName = thisContact.FirstName;
			spaceName = ' ';
		}
		
		String fullName = firstName + spaceName + thisContact.LastName;
		
		Audit_Trail thisAuditTrail = new Audit_Trail();
		thisAuditTrail.date = Datetime.now();
		thisAuditTrail.user = User.getById(UserInfo.getUserId());
		thisAuditTrail.action = 'Viewed Record';
		thisAuditTrail.detail = 'User viewed Contact ' + fullName;
		
		insert thisAuditTrail;
		
		
	}
}