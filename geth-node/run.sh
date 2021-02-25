geth init --datadir ./data/$1 ./data/$2.json

echo "======================== 
       Init done. 
========================"

geth --networkid 7333 --datadir ./data/$1 --nodiscover --http --http.port "8545" --port "30303" --http.corsdomain "*" --http.addr "0.0.0.0" --http.api="eth,net,personal,web3,debug,admin,miner" --ipcdisable
