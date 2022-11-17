public class OrderProductExtension {
private String sortOrder = 'TotalPrice';
private String currentId;

public OrderProductExtension(ApexPages.StandardController stdController){
    this.currentId = stdController.getId();
}

public List<OrderItem>  getProducts(){

    List<OrderItem> products = Database.query('SELECT Quantity, PricebookEntry.Product2.Name, UnitPrice, TotalPrice FROM OrderItem WHERE' +
    ' orderId =: currentId ORDER BY ' + sortOrder + ' ASC');

    return products;
}

public void sortByName(){
    this.sortOrder = 'PricebookEntry.Product2.Name';
}

public void sortByQuantity(){
    this.sortOrder = 'Quantity';
}

public void sortByUnitPrice(){
    this.sortOrder = 'UnitPrice';
}
    public void sortbyTotalPrice(){
    this.sortOrder = 'TotalPrice';
}
}