# Setup a Private Blockchain

## Prerequisites

- Geth installed together with the dev-tools. [Installation](https://geth.ethereum.org/docs/install-and-build/installing-geth)

## Setup

### 1. Config file

#### General information about the config file

Firstly we will need to create a config file which will describe how the private Blockchain will look like. This will also describe the Genesis block.

> The Genesis block is the first block that will be created in a Blockchain. We will create the block later on.

You can either create this file manually or by using a tool called "Puppeth".
You can find an example of this file here `'example/genesis.json'`.

So one way to go is to copy the contents of this file into your own file.

Another way to create this file is by using the tool "Puppeth" which is included in the dev-tools when installing Geth.

#### Creation of the config file

The following steps will show you how to use Puppeth to make this configuration file.

1. Start the puppeth tool

```
$ puppeth
```

2. Then you will need to specify a network name, this can be what you want but make sure you can remember it.

```
> privatechain
```

3. Now you will get a menu with several options. Pick the one "Configure new genesis" by typing 2.

4. Now you get the option to create one from scratch or import one which is already made. We will opt to create a new one. Pick "Create new genesis from scratch".

5. In this step you will get to choose which consensus engine you would like to use. This is free to choose but in our case we will go with "Ethash - proof of work".

6. Next puppeth will ask you which accounts you would like to pre-fund. There is a chance that puppeth has already written `0x`, you can leave it like that and just press enter.

7. After that puppeth will ask you if you want the precompile-addresses to be pre-funded with 1 Wei. Just press enter to continue.

8. Next up it will ask you for a chain/network id. What is important here is that we use a chain/network id that is not already in use by the public Blockchains. [Here](https://besu.hyperledger.org/en/stable/Concepts/NetworkID-And-ChainID/) you can find a list of all the chain/network ids that are already taken. For example 7979 or 5222 are valid for a private Blockchain.

Now we are done with configuring the Genesis block. The last thing we need to do is exporting this configuration.

9. If you are finished with the config you should now see a menu with almost the same options as in the beginning. Choose the option "Manage existing genesis" by typing 2.

10. Here you will have to choose "Export genesis configurations".

11. Right now you will be prompted where you want to save these files. In order to save the files you will need to specify a path or you can leave it blank if you want to save it in the current directory.

12. After this the files should be created and you can quit puppeth.

### 2. Create the Genesis block

You will notice that we have several files now. We will use the one that has just the network name in it. For example if you have entered "privatechain" when Puppeth asked for a network name then you wil see different files in your directory containing privatechain in the name of the files. We will use this one `'privatechain.json'`.

> Notice that if you entered something else when Puppeth asked for this, that you use the name that you specified before.

Here is an example if you would use a different network name when Puppeth asked for it:

```
Please specify a network name to administer (no spaces, hyphens or capital letters please):

> myprivateblockchain
```

In this case you will need to use `'myprivateblockchain.json'`.

> Note that we do not use myprivateblockchain further in the documentation but **privatechain**. This was just an example.

Command to **create** the Genesis block together with all the necessary files:

```
$ geth --datadir ./privatechain-data init privatechain.json
```

When this command is done a folder called "privatechain-data" will be created.

In this folder you can find two more folders called: `geth` & `keystore`.

`Geth` will containt all the blockchain data and `keystore` all the keys.

### 3. Create accounts in our Blockchain

In order to do something on our Blockchain like sending transactions or mining we will need an account.

This account can receive Ether from the mining process but can also use Ether to deploy smart contracts for example.

Command to create an account:

```
$ geth --datadir ./privatechain-data account new
```

After this you will be prompted to enter a password and to re-enter this password.

> Please remember the password you used.

When this is done you will see something like this:

![Screenshot](./images/account_creation_screenshot.png)

You will see that this command has created a file in the `'keystore'` folder.

Additionally you will see a public address of the key. This is the address of the account we just created in our Blockchain.

To see all the accounts you can use this command:

```
$ geth --datadir ./privatechain-data account list
```

![Screenshot](./images/account_list_screenshot.png)

In our case there will be just one address. **Copy this address because we will need it later on.**

> Not that in your case it will be a different string.

### 4. Run our first node and start mining

Before running the node you will need to create a file which will contain the password of your account you just created.

Create a file: `pwd.sec` & put your password in the file.

This is the command to run your node and immediately start mining:

```
$ geth --networkid 5333 --mine --miner.threads 1 --datadir "./privatechain-data" --nodiscover --http --http.port "8545" --port "30303" --http.corsdomain "*" --http.api="db,eth,net,personal,web3,debug,admin,miner" --unlock "address you copied" --password ./pwd.sec --allow-insecure-unlock
```
