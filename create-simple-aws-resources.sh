#!/bin/bash

echo "Select a resource to create:"
echo "1. S3 Bucket"
echo "2. EC2 Instance"
echo "3. RDS Database"
read -p "Enter the number of your choice: " choice

case $choice in
    1)
        aws s3api create-bucket --bucket my-simple-bucket --region us-west-2 --create-bucket-configuration LocationConstraint=us-west-2
        echo "S3 bucket 'my-simple-bucket' created."
        ;;
    2)
        aws ec2 run-instances --image-id ami-0abcdef1234567890 --count 1 --instance-type t2.micro --key-name MyKeyPair
        echo "EC2 instance created."
        ;;
    3)
        aws rds create-db-instance --db-instance-identifier mydbinstance --db-instance-class db.t2.micro --engine mysql --allocated-storage 20 --master-username admin --master-user-password password
        echo "RDS database 'mydbinstance' created."
        ;;
    *)
        echo "Invalid choice. Please run the script again and select a valid option."
        ;;
esac

