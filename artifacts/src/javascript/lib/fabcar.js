/*
 * Copyright IBM Corp. All Rights Reserved.
 *
 * SPDX-License-Identifier: Apache-2.0
 */

'use strict';

const { Contract } = require('fabric-contract-api');

class FabCar extends Contract {

    async initLedger(ctx) {
        console.info('============= START : Initialize Ledger ===========');
        const patients = [
            {
                id: 1,
                name: 'Test',
                dob: '2000-04-17',
                location: 'Ntinda',
                insured : true
            },
        ];

        for (let i = 0; i < patients.length; i++) {
            patients[i].nationality = 'Uganda';
            await ctx.stub.putState('UG-' + i, Buffer.from(JSON.stringify(patients[i])));
            console.info('Added <--> ', patients[i]);
        }
        console.info('============= END : Initialize Ledger ===========');
    }

    async queryPatient(ctx, id) {
        const patientAsBytes = await ctx.stub.getState(id); // get the car from chaincode state
        if (!patientAsBytes || patientAsBytes.length === 0) {
            throw new Error(`${id} does not exist`);
        }
        console.log(patientAsBytes.toString());
        return patientAsBytes.toString();
    }

    async createPatient(ctx, id, name, dob, location, insured) {
        console.info('============= START : Create Patient ===========');

        const car = {
            name,
            nationality: 'Ugandan',
            make,
            model,
            owner,
        };

        await ctx.stub.putState(id, Buffer.from(JSON.stringify(car)));
        console.info('============= END : Create Patient ===========');
    }

    async queryAllPatients(ctx) {
        const startKey = '';
        const endKey = '';
        const allResults = [];
        for await (const {key, value} of ctx.stub.getStateByRange(startKey, endKey)) {
            const strValue = Buffer.from(value).toString('utf8');
            let record;
            try {
                record = JSON.parse(strValue);
            } catch (err) {
                console.log(err);
                record = strValue;
            }
            allResults.push({ Key: key, Record: record });
        }
        console.info(allResults);
        return JSON.stringify(allResults);
    }

    async changePatientStatus(ctx, id, insured) {
        insured = false;
        console.info('============= START : changeStatus ===========');

        const patientAsBytes = await ctx.stub.getState(id); // get the car from chaincode state
        if (!patientAsBytes || patientAsBytes.length === 0) {
            throw new Error(`${id} does not exist`);
        }
        const patient = JSON.parse(patientAsBytes.toString());
        patient.insured = insured;

        await ctx.stub.putState(id, Buffer.from(JSON.stringify(car)));
        console.info('============= END : changeStatus ===========');
    }

}

module.exports = FabCar;
