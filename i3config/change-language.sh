#!/usr/bin/env bash
EN_ibus="BambooUs"
VN_ibus="Bamboo"
lang=`ibus engine`

if [ $lang = $EN_ibus ];then
  ibus engine $VN_ibus
fi
if [ $lang = $VN_ibus ];then
  ibus engine $EN_ibus
fi

