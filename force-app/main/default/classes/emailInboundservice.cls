global class emailInboundservice implements Messaging.InboundEmailHandler {
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email,Messaging.InboundEnvelope env )
    {
        Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
        
        String myPlainText = email.plainTextBody;                                           
        system.debug(myPlainText);
        Case myCase = new Case();
        if( myPlainText.containsIgnoreCase('brand')){
            Integer xb = myPlainText.indexOf('brand:');
            integer yb =xb+6;
            string strb = (myPlainText.substring(yb));
            List<String> resb = strb.split('\n');
            List<String> resb1 = resb[0].split(' ');
            myCase.Brand__c = resb1[0];
        }                                    
        if(myPlainText.containsIgnoreCase('website')){
            Integer x = myPlainText.indexOf('website:');
            
            integer y =x+8;
            string str = (myPlainText.substring(y));
            List<String> res = str.split('\n');
            List<String> res1 = res[0].split(' ');
            myCase.Website__c  =  res1[0];
                                
        myCase.description = myPlainText;
        myCase.Subject = email.subject;
        insert myCase;        
        
    }
        return result;
    }
}