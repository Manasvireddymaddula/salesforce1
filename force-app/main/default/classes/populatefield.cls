public class populatefield {
     @InvocableVariable(label='Case')
    public Case c;
        @InvocableMethod
        public static void populateFieldvalue(List<Case> cases) {
        // testing by trying to populate text field
       // cases[0].Store_Order_Number__c = 'hi';
             update cases;
    }

}