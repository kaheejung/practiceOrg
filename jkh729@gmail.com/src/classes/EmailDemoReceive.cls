global class EmailDemoReceive implements Messaging.InboundEmailHandler {
	
	global Messaging.InboundEmailResult handleInboundEmail(Messaging.inboundEmail email,
																Messaging.InboundEnvelope env) {
 
		// Create an InboundEmailResult object for returning the result of the
		// Apex Email Service
		
		Account account;
		Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
		
		try{
			if([SELECT count() FROM Account WHERE Name = :email.subject] == 0){
				account = new Account();
				account.Name = email.subject;
				Insert account;

				system.debug('이메일 들어옴? subject : ' + email.subject);
			}else{
				account = [SELECT Id FROM Account WHERE Name = :email.subject];
			}

			// Convert cc'd addresses to contacts
			for (String address : email.ccAddresses) {
			  Contact contact = new Contact();
			  Matcher matcher = Pattern.compile('<.+>').matcher(address);
			 
			  // Parse addresses to names and emails
			  if (matcher.find()) {
			    String[] nameParts = address.split('[ ]*<.+>')[0].replace('"', '').split('[ ]+');
			   
			    contact.FirstName = nameParts.size() > 1 ? nameParts[0] : '';
			    contact.LastName = nameParts.size() > 1 ? nameParts[nameParts.size()-1] : nameParts[0];
			    contact.Email = matcher.group().replaceAll('[<>]', '');
			  } else {
			    contact.LastName = address;
			    contact.Email = address;
			  }
			 
			  // Add if new
			  if ([select count() from Contact where Email = :contact.Email] == 0) {
			    contact.AccountId = account.Id;
			    insert contact;
			  }
			}

			// Save attachments, if any
			for (Messaging.Inboundemail.TextAttachment tAttachment : email.textAttachments) {
			  Attachment attachment = new Attachment();
			 
			  attachment.Name = tAttachment.fileName;
			  attachment.Body = Blob.valueOf(tAttachment.body);
			  attachment.ParentId = account.Id;
			  insert attachment;
			}
			for (Messaging.Inboundemail.BinaryAttachment bAttachment : email.binaryAttachments) {
			  Attachment attachment = new Attachment();
			 
			  attachment.Name = bAttachment.fileName;
			  attachment.Body = bAttachment.body;
			  attachment.ParentId = account.Id;
			  insert attachment;
			}

			// Turn email body into note
			Note note = new Note();

			note.Title = email.fromName + ' (' + DateTime.now() + ')';
			note.Body = email.plainTextBody;
			note.ParentId = account.Id;
			insert note;
			result.success = true;
	    } catch (Exception e) {
	      result.success = false;
	      result.message = 'Oops, I failed.';
	    }
		
		return result;
	}
}