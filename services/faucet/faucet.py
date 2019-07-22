from subprocess import Popen, PIPE
import CodaClient
import os


def ansible_faucet_transaction(recipient, amount):
    """A quick and dirty hack to get the faucet running on a laptop with ansible configured
    """
    TESTNET = "genesis_test"
    privkey_path = "/home/admin/wallet-keys/0"
    payment_command = "CODA_PRIVKEY_PASS=testnet coda client send-payment -amount {} -privkey-path {} -receiver {}".format(
        amount, 
        privkey_path, 
        recipient)

    process = Popen(['./adhoc', 'tag_Name_{}_us_west_2_proposer_0'.format(TESTNET), payment_command], 
        cwd="/Users/connerswann/code/coda-automation/ansible",
        stdout=PIPE, 
        stderr=PIPE)

    stdout, stderr = process.communicate()
    output = stdout.decode('ascii').split(">>")[1]
    print("STDOUT:", output)
    return output
    #print("STDERR:", stderr.decode('ascii'))

def faucet_transaction(recipient, amount): 
    """Sends a faucet transaction to a daemon located at DAEMON_HOST:DAEMON_PORT
    """
    DAEMON_HOST = os.environ.get("DAEMON_HOST", "localhost")
    DAEMON_PORT = os.environ.get("DAEMON_PORT", "8304")
    FAUCET_PUBLIC_KEY = os.environ.get("FAUCET_PUBLIC_KEY", "tNciQAUCyj35pvqiLXgpCsdiQVU2DN2sqgYiFrCG6E6muLcpBsJtSd57f9hctDAokidxyh3FxNTGzYcnLf2XG6jxj4WjqjMEekszvLSTCXtmfTK1U1HgbiyioqAn5CBXDcdGZLaTqfadts")
    FAUCET_FEE = os.environ.get("FAUCET_FEE", "2")
    memo = ""

    print(FAUCET_PUBLIC_KEY)
    coda = CodaClient.Client(graphql_host = DAEMON_HOST, graphql_port = DAEMON_PORT)
    response = coda.send_payment(recipient, FAUCET_PUBLIC_KEY, amount, FAUCET_FEE, memo)
    print(response.text)
    return response



if __name__ == "__main__":
    faucet_transaction("tNciGaGWUJZ5CtTdi25eTxdCfx4AfD25iSFZYL9MzM9sW7GRBtN9jETfZmir69unuegc638eg8TXtt2i4vuVDZ1WKNh7CtFrvURhg4Wb2zcs9gM55tpthUomq3no46s2JKWhj9em6T724f", "100")
