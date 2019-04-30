module.exports = {
  // default applies to all environments
  default: {
    // Blockchain node to deploy the contracts
    deployment: {
      host: "localhost", // Host of the blockchain node
      port: 8546, // Port of the blockchain node
      type: "ws" // Type of connection (ws or rpc),
      // Accounts to use instead of the default account to populate your wallet.
      // The order here corresponds to the order of `web3.eth.getAccounts`, so the first one is the `defaultAccount`
      /*,accounts: [
        {
          privateKey: "your_private_key",
          balance: "5 ether"  // You can set the balance of the account in the dev environment
                              // Balances are in Wei, but you can specify the unit with its name
        },
        {
          privateKeyFile: "path/to/file", // Either a keystore or a list of keys, separated by , or ;
          password: "passwordForTheKeystore" // Needed to decrypt the keystore file
        },
        {
          mnemonic: "12 word mnemonic",
          addressIndex: "0", // Optional. The index to start getting the address
          numAddresses: "1", // Optional. The number of addresses to get
          hdpath: "m/44'/60'/0'/0/" // Optional. HD derivation path
        },
        {
          "nodeAccounts": true // Uses the Ethereum node's accounts
        }
      ]*/
    },
    // order of connections the dapp should connect to
    dappConnection: [
      "$WEB3",  // uses pre existing web3 object if available (e.g in Mist)
      "ws://localhost:8546",
      "http://localhost:8545"
    ],

    // Automatically call `ethereum.enable` if true.
    // If false, the following code must run before sending any transaction: `await EmbarkJS.enableEthereum();`
    // Default value is true.
    // dappAutoEnable: true,

    gas: "auto",

    // Strategy for the deployment of the contracts:
    // 'explicit' will only attempt to deploy the contracts that are explicitly specified inside the contracts section.
    strategy: 'explicit',
  },

  // default environment, merges with the settings in default
  // assumed to be the intended environment by `embark run`
  development: {
    deployment: {
      // Accounts to use instead of the default account to populate your wallet.
      // The order here corresponds to the order of `web3.eth.getAccounts`, so the first one is the `defaultAccount`
      accounts: [
        {
          mnemonic: "12 word mnemonic",
          addressIndex: "0",
          numAddresses: "10",
          hdpath: "m/44'/60'/0'/0/"
        }
      ]
    },
    dappConnection: [
      "ws://localhost:8546",
      "http://localhost:8545",
      "$WEB3"  // uses pre existing web3 object if available (e.g in Mist)
    ],
    strategy: 'explicit',
    ...multipleSecurityTokenTest
  },

  // merges with the settings in default
  // used with "embark run privatenet"
  privatenet: {
  },

  // merges with the settings in default
  // used with "embark run testnet"
  testnet: {
    deployment:{
      accounts: [
        {
          mnemonic: "hero rapid silk letter vicious hire absurd high shock cart glad guard",
          addressIndex: "0",
          numAddresses: "2",
          hdpath: "m/44'/60'/0'/0/"
        }
      ],
      host: "goerli.infura.io/v3/93f7933f8eac4d6ab9ca21fc95ee03b6",
      port: false,
      protocol: 'https',
      type: "rpc"
    },
    ...multipleSecurityTokenTest
  },

  // merges with the settings in default
  // used with "embark run livenet"
  livenet: {
  },

  // you can name an environment with specific settings and then specify with
  // "embark run custom_name" or "embark blockchain custom_name"
  //custom_name: {
  //}
};
