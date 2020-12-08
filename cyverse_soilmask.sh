#!/bin/bash

WORKING_FOLDER=$(pwd)

# Get the Ortho image file
if [[ "${1}" == "" ]]; then
  echo "Orthogonal image to soil-mask is not specified"
  exit 1
fi
ORTHO_IMAGE="${1}"

# Get the mask file name
ORTHO_FILENAME=${ORTHO_IMAGE#"$(dirname "${ORTHO_IMAGE}")/"}
MASK_FILE=${ORTHO_FILENAME%.*}_mask.${ORTHO_FILENAME##*.}

# No supported options at this time
OPTIONS=""

echo "Masking image file '${WORKING_FOLDER}/${ORTHO_IMAGE}' to file '${MASK_FILE}'"
echo "{" >"/scif/apps/src/jx-args.json"
{
  echo "\"SOILMASK_SOURCE_FILE\": \"${WORKING_FOLDER}/${ORTHO_IMAGE}\","
  echo "\"SOILMASK_MASK_FILE\": \"${MASK_FILE}\","
  echo "\"SOILMASK_WORKING_FOLDER\": \"${WORKING_FOLDER}\","
  echo "\"SOILMASK_OPTIONS\": \"${OPTIONS}\""
  echo "}"
} >>"/scif/apps/src/jx-args.json"

scif run soilmask
