#! /bin/bash
cd /home/container
echo "MultiVersion 21.09 | github.com/MultiVersion"

if [[ -z $D_FILE || -z $D_FRAMEWORK ]]; then
  echo "You missed one of variables who nodexpython image needs!"
fi

if [[ -z D_DISABLE_SMART ]]; then
  if [[ ${D_FRAMEWORK,,} == "nodejs*" && ! -d node_modules && -f package.json ]]; then
    npm install
  fi
  if [[ ${D_FRAMEWORK,,} == "python*" && -f requirements.txt ]]; then
    pip install -r requirements.txt
  fi
fi

if [[ ${D_FRAMEWORK,,} == nodejs* ]]; then
    node $D_FILE
    exit 1
fi

if [[ ${D_FRAMEWORK,,} == "python3" ]]; then
  python3 $D_FILE
  exit 1
fi

if [[ ${D_FRAMEWORK,,} == "python2" ]]; then
  python2 $D_FILE
  exit 1
fi

exit 1