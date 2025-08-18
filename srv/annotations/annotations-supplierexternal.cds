using {ProductSRV as service} from '../service';

annotate service.VH_Supplier with {
    @title: 'Suppliers'
    Supplier @Common: {
        Text: SupplierName,
        TextArrangement : #TextOnly
    };
};