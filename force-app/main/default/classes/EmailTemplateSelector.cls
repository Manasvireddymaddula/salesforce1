global class EmailTemplateSelector implements QuickAction.QuickActionDefaultsHandler {
     global EmailTemplateSelector() { }
      global void onInitDefaults(QuickAction.QuickActionDefaults[] defaults) {
        QuickAction.SendEmailQuickActionDefaults sendEmailDefaults = null;
    
    
        // Check if the quick action is the standard case feed Send Email action
        for (Integer j = 0; j < defaults.size(); j++) {
            if (defaults.get(j) instanceof QuickAction.SendEmailQuickActionDefaults && 
               defaults.get(j).getTargetSObject().getSObjectType() == 
                   EmailMessage.sObjectType && 
               defaults.get(j).getActionName().equals('Case.Email') && 
               defaults.get(j).getActionType().equals('Email')) {
                   sendEmailDefaults = 
                       (QuickAction.SendEmailQuickActionDefaults)defaults.get(j);
                   break;
            }
        }
        
        if (sendEmailDefaults != null) {
            Case c = [SELECT Status,website__c,Brand__c, Reason FROM Case 
                      WHERE Id=:sendEmailDefaults.getContextId()];
        
            EmailMessage emailMessage = (EmailMessage)sendEmailDefaults.getTargetSObject();    
            // Set BCC address to make sure each email goes for audit
            emailMessage.BccAddress = getBccAddress(c.Reason);
            
            /* 
            Set Template related fields 
            when the In Reply To Id field is null we know the interface 
            is called on page load. Here we check if 
            there are any previous emails attached to the case and load 
            the 'New_Case_Created' or 'Automatic_Response' template.
            When the In Reply To Id field is not null we know that 
            the interface is called on click of reply/reply all 
            of an email and we load the 'Default_reply_template' template
            */
            if (sendEmailDefaults.getInReplyToId() == null) {
                Integer emailCount = [SELECT count() FROM EmailMessage 
                                      WHERE ParentId=:sendEmailDefaults.getContextId()];
                if (emailCount!= null && emailCount > 0) {
                    sendEmailDefaults.setTemplateId(
                        getTemplateIdHelper('Automatic_Response'));
                } else {
                    sendEmailDefaults.setTemplateId(
                        getTemplateIdHelper('New_Case_Created'));
                }
                sendEmailDefaults.setInsertTemplateBody(false);
                sendEmailDefaults.setIgnoreTemplateSubject(false);
            } else {
                sendEmailDefaults.setTemplateId(
                    getTemplateIdHelper('Default_reply_template'));
                sendEmailDefaults.setInsertTemplateBody(false);
                sendEmailDefaults.setIgnoreTemplateSubject(true);
            }
        }
    }
    
    private Id getTemplateIdHelper(String templateApiName) {
        Id templateId = null;
        try {
            templateId = [select id, name from EmailTemplate 
                          where developername = : templateApiName].id;   
        } catch (Exception e) {
            system.debug('Unble to locate EmailTemplate using name: ' + 
                templateApiName + ' refer to Setup | Communications Templates ' 
                    + templateApiName);
        }
        return templateId;
    }
private String getBccAddress(String reason) {
        if (reason != null && reason.equals('Technical')) 
            { return 'support_technical@mycompany.com'; } 
        else if (reason != null && reason.equals('Billing')) 
            { return 'support_billing@mycompany.com'; } 
        else { return 'support@mycompany.com'; }
    }
 }