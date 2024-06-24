#!/bin/bash

# Variables
PROJECT_ID=$(gcloud config get-value project)
REGION1="us-central1"
REGION2="us-east1"
VM_ZONE="us-central1-c"
INSTANCE_TEMPLATE1="${REGION1}-template"
INSTANCE_TEMPLATE2="${REGION2}-template"
INSTANCE_GROUP1="${REGION1}-mig"
INSTANCE_GROUP2="${REGION2}-mig"

# Borrar instancias de computadora
echo "Borrando instancias de computadora..."
gcloud compute instances delete siege-vm --zone=$VM_ZONE --quiet

# Borrar grupos de instancias administradas
echo "Borrando grupos de instancias administradas..."
gcloud compute instance-groups managed delete $INSTANCE_GROUP1 --region=$REGION1 --quiet
gcloud compute instance-groups managed delete $INSTANCE_GROUP2 --region=$REGION2 --quiet

# Borrar plantillas de instancias
echo "Borrando plantillas de instancias..."
gcloud compute instance-templates delete $INSTANCE_TEMPLATE1 --quiet
gcloud compute instance-templates delete $INSTANCE_TEMPLATE2 --quiet

# Borrar reglas de firewall
echo "Borrando reglas de firewall..."
gcloud compute firewall-rules delete default-allow-http --quiet
gcloud compute firewall-rules delete default-allow-health-check --quiet

# Borrar reglas de reenvío y proxies HTTP
echo "Borrando reglas de reenvío y proxies HTTP..."
gcloud compute forwarding-rules delete http-lb-forwarding-rule --global --quiet
gcloud compute forwarding-rules delete http-lb-forwarding-rule-2 --global --quiet
gcloud compute target-http-proxies delete http-lb-target-proxy --quiet
gcloud compute target-http-proxies delete http-lb-target-proxy-2 --quiet
gcloud compute url-maps delete http-lb --quiet
gcloud compute backend-services delete http-backend --global --quiet
gcloud compute health-checks delete http-health-check --quiet

# Borrar políticas de seguridad
echo "Borrando políticas de seguridad..."
gcloud compute security-policies delete denylist-siege --quiet

echo "Todos los recursos especificados han sido eliminados."

# Fin del script
