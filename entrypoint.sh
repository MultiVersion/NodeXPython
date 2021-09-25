#! /bin/bash
cd /home/container
echo "MultiVersion 21.09 | github.com/MultiVersion"
if [[ ${D_FRAMEWORK,,} == "nodejs*" ]]; then
    if [[ ! -d node_modules ]]; then
      npm install
    fi
    exec "node $@"
fi

if [[ ${D_FRAMEWORK,,} == "python3" ]]; then
  if [[ -f requirements.txt ]]; then
    pip install -r requirements.txt
  fi
  exec "python3 $@"
fi

if [[ ${D_FRAMEWORK,,} == "python2" ]]; then
  if [[ -f requirements.txt ]]; then
    pip install -r requirements.txt
  fi
  exec "python2 $@"
fi
exit 1