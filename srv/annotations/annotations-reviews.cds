using {ProductSRV as service} from '../service';

annotate service.Reviews with {
    date       @title: 'Creation Date';
    user       @title: 'User';
    rating     @title: 'Rating';
    reviewText @title: 'Review Text';
};

annotate service.Reviews with @(
    UI.LineItem  : [
        {
            $Type : 'UI.DataField',
            Value : date
        },
        {
            $Type : 'UI.DataField',
            Value : user
        },
        {
            $Type : 'UI.DataField',
            Value : rating
        },
        {
            $Type : 'UI.DataField',
            Value : reviewText
        }
    ],
    UI.FieldGroup #Review : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : date
            },
            {
                $Type : 'UI.DataField',
                Value : user
            },
            {
                $Type : 'UI.DataField',
                Value : rating
            },
            {
                $Type : 'UI.DataField',
                Value : reviewText
            }
        ],
    },
    UI.Facets: [
        {
            $Type : 'UI.ReferenceFacet',
            Target : '@UI.FieldGroup#Review',
            Label : 'Review Details',
            ID: 'ReviewDetails'
        }
    ]
);
