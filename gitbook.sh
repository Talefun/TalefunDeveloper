#bash

MESSAGE="$1"

if [[ $MESSAGE == "" ]]; then
  echo "err: 缺少commit的描述信息。"
else
  git checkout master
  rm -rf _book
  gitbook build
  git add .
  git commit -m $MESSAGE
  git push -u origin master
  git checkout gh-pages
  cp -r _book/* .
  git add .
  git commit -m $MESSAGE
  git push -u origin gh-pages
  git checkout master
fi

