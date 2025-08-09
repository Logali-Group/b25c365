using {ProductSRV as service} from '../service';

annotate service.VH_Options with {
    @title: 'Options'
    code @Common: {
        Text: name,
        TextArrangement : #TextOnly
    };
};
