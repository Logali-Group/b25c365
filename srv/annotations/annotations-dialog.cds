using {ProductSRV as service} from '../service';

annotate service.dialog with {
    option @title: 'Option' @mandatory;
    amount @title : 'Amount' @mandatory;
};

annotate service.dialog with {
    option @Common: {
        Text: option,
        TextArrangement : #TextOnly,
        ValueList : {
            CollectionPath : 'VH_Options',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : option,
                    ValueListProperty : 'code'
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'name'
                }
            ]
        },
    }
};
