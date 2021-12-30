#!/usr/bin/env bash

set -x

export LOCATION=germanywestcentral

export RESOURCE_GROUP=AZURE-AKS
export CLUSTER_NAME=AKS-UPGRADE

az group create \
    --name ${RESOURCE_GROUP} \
    --location ${LOCATION}

sleep 20

az aks create \
    --resource-group ${RESOURCE_GROUP} \
    --name ${CLUSTER_NAME} \
    --node-count 1 \
    --kubernetes-version 1.19.13

sleep 60

az aks get-credentials \
    --resource-group ${RESOURCE_GROUP} \
    --name ${CLUSTER_NAME} \
    --overwrite-existing

kubectl get nodes

sleep 20

az aks upgrade \
    --resource-group ${RESOURCE_GROUP} \
    --name ${CLUSTER_NAME} \
    --kubernetes-version 1.20.13 \
    --yes

sleep 60

az aks get-credentials \
    --resource-group ${RESOURCE_GROUP} \
    --name ${CLUSTER_NAME} \
    --overwrite-existing

kubectl get nodes

sleep 20

az aks upgrade \
    --resource-group ${RESOURCE_GROUP} \
    --name ${CLUSTER_NAME} \
    --kubernetes-version 1.21.7 \
    --yes

sleep 60

az aks get-credentials \
    --resource-group ${RESOURCE_GROUP} \
    --name ${CLUSTER_NAME} \
    --overwrite-existing

kubectl get nodes

sleep 20

az aks upgrade \
    --resource-group ${RESOURCE_GROUP} \
    --name ${CLUSTER_NAME} \
    --kubernetes-version 1.22.4 \
    --yes

sleep 60

az aks get-credentials \
    --resource-group ${RESOURCE_GROUP} \
    --name ${CLUSTER_NAME} \
    --overwrite-existing

kubectl get nodes

sleep 20

az aks delete \
    --resource-group ${RESOURCE_GROUP} \
    --name ${CLUSTER_NAME} \
    --yes

sleep 20

az group delete \
    --name ${RESOURCE_GROUP} \
    --no-wait \
    --yes

sleep 20