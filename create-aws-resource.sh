#!/bin/bash

echo "Select a resource to create:"
echo "1. S3 Bucket"
echo "2. EC2 Instance"
echo "3. RDS Database"
read -p "Enter the number of your choice: " choice

case $choice in
    1)
        read -p "Enter the S3 bucket name: " BUCKET_NAME
        read -p "Enter the region: " REGION
        aws s3api create-bucket --bucket $BUCKET_NAME --region $REGION --create-bucket-configuration LocationConstraint=$REGION
        echo "S3 bucket $BUCKET_NAME created in region $REGION."
        ;;
    2)
        read -p "Enter the instance type (e.g., t2.micro): " INSTANCE_TYPE
        read -p "Enter the key pair name: " KEY_NAME
        aws ec2 run-instances --instance-type $INSTANCE_TYPE --key-name $KEY_NAME --image-id ami-0abcdef1234567890
        echo "EC2 instance created with type $INSTANCE_TYPE."
        ;;
    3)
        read -p "Enter the DB instance identifier: " DB_INSTANCE_IDENTIFIER
        read -p "Enter the DB instance class (e.g., db.t2.micro): " DB_INSTANCE_CLASS
        read -p "Enter the DB name: " DB_NAME
        read -p "Enter the master username: " MASTER_USERNAME
        read -sp "Enter the master password: " MASTER_PASSWORD
        echo
        aws rds create-db-instance --db-instance-identifier $DB_INSTANCE_IDENTIFIER --db-instance-class $DB_INSTANCE_CLASS --engine mysql --allocated-storage 20 --db-name $DB_NAME --master-username $MASTER_USERNAME --master-user-password $MASTER_PASSWORD
        echo "RDS database $DB_NAME created."
        ;;
    *)
        echo "Invalid choice. Please run the script again and select a valid option."
        ;;
esac
