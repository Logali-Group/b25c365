const cds = require('@sap/cds');
require('dotenv').config()

module.exports = class ProductSRV extends cds.ApplicationService {

    async init () {

        const {Products, Inventories, CustomersCloud, SuppliersCloud, BussinesPartnerOP, VH_Supplier} = this.entities;
        const cloud = await cds.connect.to("API_BUSINESS_PARTNER");
        const op = await cds.connect.to("API_BUSINESS_PARTNER_ONPREMISE");

        this.on('READ', [BussinesPartnerOP, VH_Supplier], async (req) => {
            return await op.tx(req).send({
                query: req.query,
                headers: {
                    Authorization: process.env.AUTH
                }
            });
        });

        this.on('READ', [CustomersCloud, SuppliersCloud], async (req) => {
            return await cloud.tx(req).send({
                query: req.query,
                headers: {
                    apikey: process.env.APIKEY
                }
            });
        });

        //http://s4h22.sap4practice.com:8007/sap/opu/odata/sap/API_BUSINESS_PARTNER

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

        this.on('setStock', async (req) => {

            const productId = req.params[0].ID;
            const inventiryId = req.params[1].ID;
            const data = req.data; //Option & Amount

            const object = await SELECT.one.from(Inventories).columns('quantity').where({ID: inventiryId}); //{quantity : XXX}
            let newAmount = 0;
            
            if (data.option === 'A') {
                newAmount = object.quantity + data.amount;

                if (newAmount > 300) {
                    await UPDATE(Products).set({statu_code: 'InStock'}).where({ID: productId});
                }

                await UPDATE(Inventories).set({quantity: newAmount}).where({ID: inventiryId});
                return req.info(200, `The amount ${req.data.amount} has been added to the inventoy`);

            } else if ( (object.quantity < data.amount ) ) {
                return req.error(400, `There is no avalilability for the requested quantity`);
            } else {
                newAmount = object.quantity - data.amount;
                if (newAmount > 0 && newAmount <= 300) {
                    await  UPDATE(Products).set({statu_code: 'LowAvailability'}).where({ID: productId});
                } else if (newAmount === 0) {
                    await  UPDATE(Products).set({statu_code: 'OutOfStock'}).where({ID: productId});
                }

                await UPDATE(Inventories).set({quantity: newAmount}).where({ID: inventiryId});
                return req.info(200, `The amount ${data.amount} has been removed the invenroty`);
            }

        });


        return super.init();
    }

}