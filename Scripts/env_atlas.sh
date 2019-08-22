export DATA_DIR=data

if [ ! -d ${DATA_DIR} ]
then
  mkdir -p ${DATA_DIR}
fi

function getDataFilePath() {
  local fileName=$1

  echo "${DATA_DIR}/${fileName}"
}
