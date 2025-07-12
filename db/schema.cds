namespace com.logaligroup;

type decimal : Decimal(5, 3);

entity Products {
    key ID          : UUID;
    key product     : String(8);
        productName : String(80);
        description : LargeString;
        category    : String;
        subCategory : String;
        statu       : String;
        price       : Decimal(8, 2);
        rating      : Decimal(3, 2);
        currency    : String;
        detail      : Association to ProductDetails; //detail detail_ID:
};

entity ProductDetails {
    key ID         : UUID;
        baseUnit   : String default 'EA';
        width      : decimal;
        height     : decimal;
        depth      : decimal;
        weight     : decimal;
        unitVolume : String default 'CM';
        unitWeight : String default 'KG';
};


/** Value Helps */

entity Categories {
    key ID              : UUID;
        category        : String(80);
        toSubCategories : Association to many SubCategories
                              on toSubCategories.category = $self;
};

entity SubCategories {
    key ID          : UUID;
        subCategory : String(80);
        category    : Association to Categories; // category category_ID
};
