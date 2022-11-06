

#Apply the kube object
kubectl apply -f Yaml/job-s3.yaml

#Check pod is running or not
kubectl get job -l app=eks-iam-test-s3


#check the logs to verify 

kubectl logs -l app=eks-iam-test-s3
