public class emailmsgsplit {
    public String message{set;get;}
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
                    when 'TextMessage'{
                        wsm.TextMessage=label+':'+value;
                    }
                    when 'Name' {
                        wsm.Name=label+':'+value;
                    }
                    when 'LastName' {
                        wsm.LastName=label+':'+value;
                    }
                    when 'Email' {
                        wsm.Email=label+':'+value;
                    }
                     when 'Phone' {
                        wsm.Phone=label+':'+value;
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
                    when 'Brand' {
                        wsm.Brand=label+':'+value;
                    }
                    when 'website' {
                        wsm.website=label+':'+value;
                    }
                     when 'Zip' {
                        wsm.Zip=label+':'+value;
                    }
                    when 'Comment'
                    {
                       wsm.Comments=label+':'+value;
                    }



               }
            }
           
        system.debug('Wsm:==>'+wsm);        
    }


}