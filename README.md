 #create pod
 
apiVersion: batch/v1
kind: Job
metadata:
  name: eks-iam-test-s3
  namespace: default
spec:
  template:
    metadata:
      labels:
        app: eks-iam-test-s3
    spec:
      serviceAccountName: iam-test
      containers:
      - name: eks-iam-test
        image: amazon/aws-cli:latest
        args: ["s3", "ls"]
      restartPolicy: Never

#Apply the kube object
kubectl apply -f Yaml/job-s3.yaml

#Check pod is running or not
kubectl get job -l app=eks-iam-test-s3


#check the logs to verify 

kubectl logs -l app=eks-iam-test-s3