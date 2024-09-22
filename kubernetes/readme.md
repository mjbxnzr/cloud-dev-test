### K8s local setup

- Setup & install [kind](https://kind.sigs.k8s.io/)
- Run `kind create clusters --name <your-cluster-name>`

### K8s with EKS setup

- Create EKS cluster using `eksctl`

````
> eksctl create cluster \
--name test-cluster-05 \
--region ap-southeast-1 \
--version 1.30 \
--nodegroup-name linux-nodes \
--node-type t2.micro \
--nodes 2

````


#### Prerequisites
Since we're using AWS EFS, it's essential to install the EFS CSI driver.
```commandline
> helm repo add aws-efs-csi-driver https://kubernetes-sigs.github.io/aws-efs-csi-driver/
> helm repo update aws-efs-csi-driver
> helm upgrade --install aws-efs-csi-driver --namespace kube-system aws-efs-csi-driver/aws-efs-csi-driver
```