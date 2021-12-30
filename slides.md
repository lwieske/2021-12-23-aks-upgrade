---
marp: true
---

<!-- _class: invert -->

## Upgrade An AKS Cluster

* Part of the AKS cluster lifecycle involves performing periodic upgrades to the
  latest Kubernetes version. It is important you apply the latest security
  releases, or upgrade to get the latest features. This article shows you how to
  upgrade the master components or a single, default node pool in an AKS
  cluster.

* For AKS clusters that use multiple node pools or Windows Server nodes, see
  Upgrade a node pool in AKS.

---

## Warning

* An AKS cluster upgrade triggers a cordon and drain of your nodes. If you have
  a low compute quota available, the upgrade may fail.

---

## Check for available AKS cluster upgrades

* To check which Kubernetes releases are available for your cluster, use the *az
  aks get-upgrades* command. The following example checks for available upgrades
  to myAKSCluster in myResourceGroup:

```
az aks get-upgrades \
  --resource-group myResourceGroup \
  --name myAKSCluster \
  --output table
```

---

## Sequential Upgrades

* When you upgrade a supported AKS cluster, Kubernetes minor versions cannot be
  skipped. All upgrades must be performed sequentially by major version number.
  For example, upgrades between 1.14.x -> 1.15.x or 1.15.x -> 1.16.x are
  allowed, however 1.14.x -> 1.16.x is not allowed.

* Skipping multiple versions can only be done when upgrading from an unsupported
  version back to a supported version. For example, an upgrade from an
  unsupported 1.10.x --> a supported 1.15.x can be completed.

---

## Upgrade An AKS Cluster

* During the upgrade process, AKS will:

  * add a new buffer node (or as many nodes as configured in max surge) to the
    cluster that runs the specified Kubernetes version.

  * cordon and drain one of the old nodes to minimize disruption to running
    applications (if you're using max surge it will cordon and drain as many
    nodes at the same time as the number of buffer nodes specified).

  * when the old node is fully drained, it will be reimaged to receive the new
    version and it will become the buffer node for the following node to be
    upgraded.

* This process repeats until all nodes in the cluster have been upgraded.

* At the end of the process, the last buffer node will be deleted, maintaining
  the existing agent node count and zone balance.

---

## AZ AKS Upgrade

```
az aks upgrade \
    --resource-group myResourceGroup \
    --name myAKSCluster \
    --kubernetes-version KUBERNETES_VERSION
```

* It takes a few minutes to upgrade the cluster, depending on how many nodes you
  have.
