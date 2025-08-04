const cds = require('@sap/cds');


module.exports = class ProductSRV extends cds.ApplicationService {

    init () {

        const {Products, Inventories} = this.entities;


        //before
        //on
        //after
        // CREATE, UPDATE, DELETE, READ (Tablas Persistentes)
        // NEW (Tablas Draft)

        this.before('NEW', Products.drafts, async (req) => {
            req.data.detail??= {
                baseUnit: 'EA',
                width: null,
                height: null,
                depth: null,
                weight: null,
                unitVolume: 'CM',
                unitWeight: 'KG'
            };
            console.log(req.data);
        });

        this.before('NEW', Inventories.drafts, async (req) => {
            let tp = await SELECT.one.from(Inventories).columns('max(stockNumber) as Max');
            let td = await SELECT.one.from(Inventories.drafts).columns('max(stockNumber) as Max');

            let tpMax = parseInt(tp.Max);
            let tdMax = parseInt(td.Max);
            let newMax = 0;


            if (isNaN(tdMax)) {
                newMax = tpMax + 1;
            } else if (tpMax < tdMax) {
                newMax = tdMax + 1;
            } else {
                newMax = tpMax + 1;
            }

            req.data.stockNumber = newMax;
        });


        return super.init();
    }

}