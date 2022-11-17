public class caseinfo {
   
  public string message{get;set;}
   // public list<Case>Result {get;set;}
    //public Wrappersplitmsg wr{set;get;}
   // public void searchbox(){
      //  result=new list<Case>();
       // result=[SELECT SuppliedName,Brand__c,CaseNumber,SuppliedPhone,SuppliedEmail,website__c from Case where  CaseNumber=:searchbox ];
        
   
    
    public Wrappersplitmsg wsm{set;get;}
    public void getMessage()
    {
String[] emailBodyRows = message.split('\n');
    string label;
     string value;
        system.debug('emailBodyRows='+emailBodyRows);
       wsm=new Wrappersplitmsg();
              for (String bodyRow:emailBodyRows) {
                  system.debug('bodyRow='+bodyRow);
                       Boolean isValid=bodyRow.contains(':');
                if(isValid==true)
                {
                  String[] rowContents = bodyRow.split(':');
                   label=rowContents[0];
                if(rowContents.size()>1)
                {
                 value=rowContents[1];
                }
                }
               
                switch on label {
                    when 'Name' {
                        wsm.SuppliedName=label+':'+value;
                    }
                    
                    when 'Email' {
                        wsm.SuppliedEmail=label+':'+value;
                    }
                     when 'Phone' {
                        wsm.SuppliedPhone=label+':'+value;
                    }
                     when 'Company' {
                        wsm.Company=label+':'+value;
                    }
                     when 'Address' {
                        wsm.Address=label+':'+value;
                    }
                     when 'City' {
                        wsm.City=label+':'+value;
                    }
                    when 'State' {
                        wsm.State=label+':'+value;
                    }
                     when 'Zip' {
                        wsm.Zip=label+':'+value;
                    }
                    when 'Comment'
                    {
                       wsm.Comments=label+':'+value;
                    }
                     when 'brand'
                     {
                         wsm.Brand=label+':'+value;
                     }
                    when 'Website'
                     {
                         wsm.website=label+':'+value;
                     }



               }
            }
}
    
}