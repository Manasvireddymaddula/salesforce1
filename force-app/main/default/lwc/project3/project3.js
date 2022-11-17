import { LightningElement } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';


export default class RedirectToRecordPage extends NavigationMixin(LightningElement) {

    navigate() {
        
        this[NavigationMixin.Navigate]
        ({
            type: 'standard__webPage',
            attributes: {
                url: 'https://lnt-electricalstandardproduct-service.force.com/slk/s/contentdocument/0692j000005BGCGAA4'
            }
        },
        true 
      );
}
}