namespace com.logaligroup;

using {
        cuid,
        managed,
        sap.common.CodeList
} from '@sap/cds/common';

type decimal : Decimal(5, 3);

entity Products : cuid, managed {
        product       : String(8);
        productName   : String(80);
        description   : LargeString;
        category      : Association to Categories;      // category & category_ID
        subCategory   : Association to SubCategories;   // subCategory & subCategory_ID
        statu         : Association to Status;          // statu statu_code
        price         : Decimal(8, 2);
        rating        : Decimal(3, 2);
        currency      : String;
        detail        : Association to ProductDetails; //detail detail_ID:
        supplier      : Association to Suppliers;
        toReviews     : Association to many Reviews
                                on toReviews.product = $self;
        toInventories : Association to many Inventories
                                on toInventories.product = $self;
        toSales       : Association to many Sales
                                on toSales.product = $self;
};

entity Suppliers : cuid {
        supplier     : String(10);
        supplierName : String(40);
        webAddress   : String(250);
        contact      : Association to Contacts;
};

entity Contacts : cuid {
        fullName    : String(40);
        email       : String(80);
        phoneNumber : String(14);
};

entity Reviews : cuid {
        rating     : Decimal(3, 2);
        date       : Date;
        reviewText : LargeString;
        user       : String(20);
        product    : Association to Products; //product_ID
};

entity Inventories : cuid {
        stockNumber : String(7);
        department  : Association to Departments;
        min         : Integer;
        max         : Integer;
        target      : Integer;
        quantity    : Decimal(4, 3);
        baseUnit    : String default 'EA';
        product     : Association to Products;
};

entity Sales : cuid {
        monthCode     : String(3);
        month         : String(20);
        quantitySales : Integer;
        year          : String(4);
        product       : Association to Products;
};


entity ProductDetails : cuid {
        baseUnit   : String default 'EA';
        width      : decimal;
        height     : decimal;
        depth      : decimal;
        weight     : decimal;
        unitVolume : String default 'CM';
        unitWeight : String default 'KG';
};

/** Code List */
//1 = Rojo
//2 = Amarillo
//3 = Verde
entity Status : CodeList {
        key code        : String(20) enum {
                    InStock = 'In Stock';
                    OutOfStock = 'Out of Stock';
                    LowAvailability = 'Low Availability';
            };
            criticality : Int16;
};


/** Value Helps */

entity Categories : cuid {
        category        : String(80);
        toSubCategories : Association to many SubCategories
                                  on toSubCategories.category = $self;
};

entity SubCategories : cuid {
        subCategory : String(80);
        category    : Association to Categories; // category category_ID
};

entity Departments : cuid {
        department : String(40);
}
