#!/bin/bash

set -euo pipefail

# RESOURCE_GROUP is needed in calling shell.
export RESOURCE_GROUP=rg-tf-obs-${RGLOCATION}

function create_terraform_storage_account_resource_group {
  az group create -n ${RESOURCE_GROUP} -l ${RGLOCATION}
}

function create_terraform_storage_account {
  STORAGE_ACCOUNT_SUFFIX=$(echo $RESOURCE_GROUP | shasum | head -c 8)
  export STORAGE_ACCOUNT="st4tf${STORAGE_ACCOUNT_SUFFIX}" # needed in calling shell
  export CONTAINER="terraform-state-${NAME}"                 # needed in calling shell
  az storage account create -n "${STORAGE_ACCOUNT}" -g "${RESOURCE_GROUP}" -l "${RGLOCATION}"
  KEY=$(az storage account keys list -g ${RESOURCE_GROUP} -n ${STORAGE_ACCOUNT} --query "[0].value" -o tsv)
  az storage container create -n "${CONTAINER}" --account-name "${STORAGE_ACCOUNT}" --account-key "${KEY}"
}

create_terraform_storage_account_resource_group
create_terraform_storage_account
