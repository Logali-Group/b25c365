using {ProductSRV as service} from '../service';

annotate service.Sales with {
    month         @title: 'Month';
    monthCode     @title: 'Month Code';
    year          @title: 'Year';
    quantitySales @title: 'Quantity Sales';
};

annotate service.Sales with @(
    Analytics.AggregatedProperty #sum: {
        $Type : 'Analytics.AggregatedPropertyType',
        Name : 'Sales',
        AggregationMethod : 'sum',
        AggregatableProperty : quantitySales,
        ![@Common.Label] : 'Sales'
    },
    Aggregation.ApplySupported: {
        $Type : 'Aggregation.ApplySupportedType',
        Transformations : [
            'aggregate',
            'groupby',
            'concat',
            'identity',
            'filter',
            'search',
            'nest',
            'addnested',
            'join',
            'outerjoin',
            'compute',
            'bottomcount',
            'bottomsum',
            'bottompercent',
            'topcount',
            'topsum',
            'toppercent',
            'orderby',
            'top',
            'skip',
            'ancestors',
            'descendants',
            'traverse',
        ],
        GroupableProperties : [
            month,
            year
        ],
        AggregatableProperties : [
            {
                $Type : 'Aggregation.AggregatablePropertyType',
                Property : quantitySales
            }
        ]
    },
    UI.Chart  : {
        $Type : 'UI.ChartDefinitionType',
        ChartType : #Line,
        Dimensions : [
            month,
            year
        ],
        DynamicMeasures : [
            '@Analytics.AggregatedProperty#sum',
        ]
    }
);

