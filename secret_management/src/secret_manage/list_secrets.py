import sys
import os

import hvac

url = namespace=os.getenv('VAULT_URL')
client = hvac.Client(url)

client.secrets.kv.v2.configure(
    mount_point='kv',
)

def main() -> None:
    print(client.is_authenticated() or False)
    print("Hello from secret-management!")

    #list_response = client.secrets.kv.v2.list_secrets(path='underdark')
     
    read_response = client.secrets.kv.v2.read_secret_version(
        path='underdark/openstack/rabbitmq-admin-user',
        mount_point='kv',
    )
    print(read_response)


if __name__ == '__main__':
    sys.exit(main()) 