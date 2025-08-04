using {ProductSRV as service} from '../service';


annotate service.Contacts with {
    fullName     @title: 'Full Name'     @Common.FieldControl: #ReadOnly;
    email        @title: 'Email'         @Common.FieldControl: #ReadOnly;
    phoneNumber  @title: 'Phone Number'  @Common.FieldControl: #ReadOnly;
};

annotate service.Contacts with @(
    UI.FieldGroup #ContactInformation: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: fullName
            },
            {
                $Type: 'UI.DataField',
                Value: email
            },
            {
                $Type: 'UI.DataField',
                Value: phoneNumber
            }
        ]
    },
    UI.Facets                        : [{
        $Type : 'UI.ReferenceFacet',
        Target: '@UI.FieldGroup#ContactInformation',
        Label : 'Contact Information',
        ID    : 'ContactInformation'
    }]
);
