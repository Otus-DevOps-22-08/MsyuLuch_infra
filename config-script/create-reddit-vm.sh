    yc compute instance create \
        --name reddit-app \
        --hostname reddit-app \
        --memory=4 \
        --create-boot-disk image-folder-id=b1g6q04gp8vhlg95vctg,image-family=reddit-full,size=10GB \
        --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
        --metadata serial-port-enable=1 \
        --ssh-key ~/.ssh/appuser.pub
