echo "Datafolder: ./$1/"
echo "Config file: ./$2.json"
echo "http port: $3"
echo "port: $4"
echo "network/chain ID: $5"

geth init --datadir ./data/$1 ./data/$2.json

echo "======================== 
       Init done. 
========================"
echo "======================== 
    Starting node... 
========================"

geth --networkid $5 --datadir ./data/$1 --nodiscover --http --http.port $3 --port $4 --http.corsdomain "*" --http.addr "0.0.0.0" --http.api="eth,net,personal,web3,debug,admin,miner" --ipcdisable --gcmode archive
