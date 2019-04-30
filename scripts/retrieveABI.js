'use strict';

const fs = require('fs');

const interfaces = ['IRegulatorService', 'ISecurityToken', 'IStoreKYC', 'IAddressIdentities'];
const abiDefs = {};
for (const item of interfaces) {
    console.log("Loading ABI definition for "+item);
    const rawData = fs.readFileSync('build/contracts/'+item+'.json');

    console.log("Parsing ABI definition for "+item);
    const parsedData = JSON.parse(rawData);
    abiDefs[item] = parsedData['abiDefinition'];
}

console.log("Encoding ABI definitions.");
const abiDefsEncoded = JSON.stringify(abiDefs);

console.log("Saving ABI definitions.");
fs.writeFileSync('abi_defs.json', abiDefsEncoded);

console.log("Done!");
