using {ProductSRV as services} from '../service';


annotate services.Products with {
    product     @title: 'Product';
    productName @title: 'Product Name';
    description @title: 'Description';
    category    @title: 'Category';
    subCategory @title: 'Sub-Category';
    statu       @title: 'Statu';
    price       @title: 'Price' @Measures.ISOCurrency: currency;
    rating      @title: 'Average Rating';
    currency    @title: 'Currency' @Common.IsCurrency;
    supplier @title : 'Supplier';
};

annotate services.Products with {
    statu @Common: {
        Text : statu.name,
        TextArrangement : #TextOnly
    };
    supplier @Common: {
        Text : supplier.supplierName,
        TextArrangement : #TextOnly,
        ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Suppliers',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : supplier_ID,
                    ValueListProperty : 'ID'
                }
            ]
        }
    };
    category @Common: {
        Text : category.category,
        TextArrangement : #TextOnly
    };
    subCategory @Common: {
        Text : subCategory.subCategory,
        TextArrangement : #TextOnly
    };
};



annotate services.Products with @(
    Capabilities.FilterRestrictions: {
        $Type : 'Capabilities.FilterRestrictionsType',
        FilterExpressionRestrictions : [
            {
                $Type : 'Capabilities.FilterExpressionRestrictionType',
                Property : productName,
                AllowedExpressions : product
            }
        ]
    },
    UI.SelectionFields: [
        product,
        productName,
        supplier_ID,
        category_ID,
        subCategory_ID,
        statu_code
    ],
    UI.HeaderInfo: {
        $Type : 'UI.HeaderInfoType',
        TypeName : 'Product',
        TypeNamePlural : 'Products',
    },
    UI.LineItem  : [
        {
            $Type : 'UI.DataField',
            Value : product
        },
        {
            $Type : 'UI.DataField',
            Value : productName
        },
        {
            $Type : 'UI.DataField',
            Value : supplier_ID
        },
        {
            $Type : 'UI.DataField',
            Value : category_ID
        },
        {
            $Type : 'UI.DataField',
            Value : subCategory_ID
        },
        {
            $Type : 'UI.DataFieldForAnnotation',
            Target : '@UI.DataPoint#Rating',
            Label : 'Average Rating',
            ![@HTML5.CssDefaults] : {
                $Type : 'HTML5.CssDefaultsType',
                width : '10rem'
            }
        },
        {
            $Type : 'UI.DataField',
            Value : statu_code,
            Criticality : statu.criticality,
            ![@HTML5.CssDefaults] : {
                $Type : 'HTML5.CssDefaultsType',
                width : '10rem'
            },
        },
        {
            $Type : 'UI.DataField',
            Value : price,
            ![@HTML5.CssDefaults] : {
                $Type : 'HTML5.CssDefaultsType',
                width : '10rem'
            },
        }
    ],
    UI.DataPoint #Rating  : {
        $Type : 'UI.DataPointType',
        Value : rating,
        Visualization : #Rating
    }
);
