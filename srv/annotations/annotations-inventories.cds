using {ProductSRV as services} from '../service';


annotate services.Inventories with {
    stockNumber @title : 'Stock Number';
    department  @title : 'Department';
    min         @title : 'Minimum Stock';
    max         @title : 'Maximum Stock';
    target      @title : 'Target Stock';
    quantity    @title : 'Quantity' @Measures.Unit : baseUnit;
    baseUnit    @title : 'Base Unit' @Common.IsUnit
};

annotate services.Inventories with {
    department @Common: {
        Text : department.department,
        TextArrangement : #TextOnly
    };
};


annotate services.Inventories with @(
    UI.HeaderInfo: {
        $Type : 'UI.HeaderInfoType',
        TypeName : 'Inventory',
        TypeNamePlural : 'Inventories',
        Title : {
            $Type : 'UI.DataField',
            Value : product.productName,
        },
        Description : {
            $Type : 'UI.DataField',
            Value : product.product
        },
    },
    UI.LineItem  : [
        {
            $Type : 'UI.DataField',
            Value : stockNumber
        },
        {
            $Type : 'UI.DataField',
            Value : department_ID
        },
        {
            $Type : 'UI.DataFieldForAnnotation',
            Target : '@UI.Chart',
            ![@HTML5.CssDefaults] : {
                $Type : 'HTML5.CssDefaultsType',
                width : '10rem',
            },
            Label : 'Target',
        },
        {
            $Type : 'UI.DataField',
            Value : quantity
        }
    ],
    UI.DataPoint #Bullet : {
        $Type : 'UI.DataPointType',
        Value : target,
        MinimumValue: min,
        MaximumValue: max,
        CriticalityCalculation : {
            $Type : 'UI.CriticalityCalculationType',
            ImprovementDirection : #Maximize,
            ToleranceRangeLowValue : 40,
            DeviationRangeLowValue : 10
        }
    },
    UI.Chart  : {
        $Type : 'UI.ChartDefinitionType',
        ChartType : #Bullet,
        Measures : [
            target
        ],
        MeasureAttributes : [
            {
                $Type : 'UI.ChartMeasureAttributeType',
                DataPoint : '@UI.DataPoint#Bullet',
                Measure : target
            }
        ]
    },
    UI.FieldGroup  : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : stockNumber
            },
            {
                $Type : 'UI.DataField',
                Value : department_ID
            },
            {
                $Type : 'UI.DataField',
                Value : min
            },
            {
                $Type : 'UI.DataField',
                Value : max
            },
            {
                $Type : 'UI.DataField',
                Value : target,
            },
            {
                $Type : 'UI.DataField',
                Value : quantity
            }
        ],
    },
    UI.Facets:[
        {
            $Type : 'UI.ReferenceFacet',
            Target : '@UI.FieldGroup',
            Label : 'Inventory Information',
            ID: 'Inventories'
        }
    ]
);

