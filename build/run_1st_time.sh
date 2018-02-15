
$daemon = "/usr/local/bin/alqod"
$cli = "/usr/local/bin/alqo-cli"
$data_dir = "/home/alqo"
#
if [ ! -d $data_dir ]; then
	echo "Creating default config file"
	$daemon --datadir="$data_dir" 2>&1 >/dev/null | grep ^rpc > $data_dir/alqo.conf	

	cat template.conf > $data_dir/alqo.conf

fi

$daemon --datadir="$data_dir"


$address=$(/usr/local/bin/alqo-cli --datadir=$datadir getaccountaddress "")


echo ""
echo "My wallet adress is : $address"
echo ""
echo ""

## encrypt
echo "Encrypting wallet ..."
$cli encryptwallet "passphrase"
### add to config file ???

## restart wallet
$daemon --datadir="$data_dir" -daemon

## backup
echo "Backuping wallet ..."
$cli backupwallet "destination

## info
echo "Wallet status"
$cli getwalletinfo

## unlock
echo "Unlocking wallet ..."
$cli walletpassphrase "passphrase" 9999999 true                       

# conf ???
autounlock=YourPassPhraseAsEncryptedString
