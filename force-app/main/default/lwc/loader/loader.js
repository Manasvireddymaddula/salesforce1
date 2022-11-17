import { LightningElement } from 'lwc';
import My_Resource from '@salesforce/resourceUrl/myResource';
export default class StaticResourceLWCExample extends LightningElement {
    spring20Logo = My_Resource + '/three.js';
    summer20Logo = My_Resource + '/three.min.js';

}