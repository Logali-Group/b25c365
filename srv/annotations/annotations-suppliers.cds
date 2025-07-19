using {ProductSRV as service} from '../service';

annotate service.Suppliers with {
    @title: 'Suppliers'
    ID @Common: {
        Text : supplierName,
        TextArrangement : #TextOnly
    }
};
