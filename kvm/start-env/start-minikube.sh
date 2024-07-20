#!/bin/bash

minikube start 
kubectl config delete-context k8s-c2
kubectl config rename-context minikube k8s-c2
kubectl config use-context k8s-c1

