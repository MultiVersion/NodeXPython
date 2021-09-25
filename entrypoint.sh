#! /bin/bash
cd /home/container

if [[ -z D_DISABLE_SMART ]]; then
  if [[ ${D_FRAMEWORK,,} == "nodejs*" && ! -d node_modules ]]; then
    npm install
  fi
  if [[ ${D_FRAMEWORK,,} == "python*" && -f requirements.txt ]]; then
    pip install -r requirements.txt
  fi
fi

echo "MultiVersion 21.09 | github.com/MultiVersion"
if [[ ${D_FRAMEWORK,,} == "nodejs*" ]]; then
    exec "node $@"
    exit 1
fi

if [[ ${D_FRAMEWORK,,} == "python3" ]]; then
  exec "python3 $@"
  exit 1
fi

if [[ ${D_FRAMEWORK,,} == "python2" ]]; then
  exec "python2 $@"
  exit 1
fi

exit 1