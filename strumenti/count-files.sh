#!/bin/zsh

COMMIT="acb92521c1b3db5e52abd6ee77eb1eef85970fe3"
DIRECTÓRIO="mimetypes"
PRECEDENTE_DIRECTÓRIO="devices"
ÍCONES="$HOME/Imagens/ícones/"
ADDED="A"
MODDED="M"
PWD="$(pwd)"

function sum()
{
  echo "- $(git difftool --no-renames --diff-filter=$ADDED --name-only $COMMIT gusbemacbe Yaru++/$DIRECTÓRIO/16 | wc -l) $DIRECTÓRIO 16px icons have been added."
  echo "- $(git difftool --no-renames --diff-filter=$ADDED --name-only $COMMIT gusbemacbe Yaru++/$DIRECTÓRIO/scalable | wc -l) $DIRECTÓRIO scalable icons have been added."

  echo "- $(git difftool --no-renames --diff-filter=$MODDED --name-only $COMMIT gusbemacbe Yaru++/$DIRECTÓRIO/16 | wc -l) $DIRECTÓRIO 16px icons have been modified."
  echo "- $(git difftool --no-renames --diff-filter=$MODDED --name-only $COMMIT gusbemacbe Yaru++/$DIRECTÓRIO/scalable | wc -l) $DIRECTÓRIO scalable icons have been modified."
}

function list()
{
  rm -rf $PWD/strumenti/liste/$PRECEDENTE_DIRECTÓRIO-scalable.txt
  git difftool --no-renames --diff-filter=$ADDED --name-only $COMMIT gusbemacbe Yaru++/$DIRECTÓRIO/scalable > $PWD/strumenti/liste/$DIRECTÓRIO-scalable.txt
  for f in `cat $PWD/strumenti/liste/$DIRECTÓRIO-scalable.txt`; do cp -f ${f} $ÍCONES; done;
}

function convert()
{
  cd $ÍCONES
  mogrify -path PNG -background White -alpha Background -format png -resize 1024x1024 *.svg
}

function createFolder()
{
  cd $ÍCONES
  rm -rf PNG *.svg
  mkdir PNG
}

# list
# convert

# createFolder