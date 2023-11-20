
const sql = require('mssql');
//const sqlpassword = require('./config.js').password;
//import config from './config.js';
//const privateKey = config.privateKey;

const config = {
  user: 'Hive-achimmertens',
  password: 'kxppeJSdzSNHEiWAjFbf',
  server: 'vip.hivesql.io',
  database: 'DBhive',
  options: {
    encrypt: true,
    trustServerCertificate: true
}
};

//const os = require('os');
const mssql = require('mssql');
//const moment = require('moment');

async function hive_sql(SQLCommand, limit) {
    //const db = process.env.HIVESQL.split(' ');
    const pool = await mssql.connect({
        server: 'vip.hivesql.io',
        user: 'Hive-achimmertens',
        password: 'kxppeJSdzSNHEiWAjFbf',
        database: 'DBhive'
    });
    const result = await pool.request().query(SQLCommand);
    return result.recordset.slice(0, limit);
}

async function get_hive_per_vest() {
    const SQLCommand = `
        SELECT hive_per_vest
        FROM DynamicGlobalProperties
    `;
    const result = await hive_sql(SQLCommand, 1);
    return result[0].hive_per_vest;
}

async function main() {
    const account_name = 'geekgirl';
    const start_date = '2022-02-01';
    const end_date = '2022-02-07';
    const hive_per_vest = await get_hive_per_vest();
    const limit = 1000;
    const SQLCommand = `
        SELECT reward_hbd, reward_hive, reward_vests * ${hive_per_vest}, timestamp
        FROM TxClaimRewardBalances
        WHERE account = '${account_name}'
        AND timestamp BETWEEN '${start_date}' AND '${end_date}'
        ORDER BY timestamp DESC
    `;
    const result = await hive_sql(SQLCommand, limit);
    console.log(result);
    console.log(result.length);
}

main();
