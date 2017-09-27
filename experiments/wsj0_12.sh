#!/bin/bash
SAVFILE='saves/wsj0_1.ckpt'
if [ ! -e $SAVFILE ]; then
    echo '1'
    python main.py -o $SAVFILE -tl=16 -bs=16 -ds=wsj0 -ne=10 --no-valid-on-epoch
    if [ ! $? == 0 ]; then exit; fi
    echo '2'
    python main.py -ds=wsj0 -i $SAVFILE -m=debug
    echo '3'
    python main.py -i $SAVFILE -tl=16 -bs=16 -o $SAVFILE -ds=wsj0 -ne=100 -lr=3e-4 --no-valid-on-epoch
    if [ ! $? == 0 ]; then exit; fi
    echo '4'
    python main.py -i $SAVFILE -tl=16 -bs=16 -o $SAVFILE -ds=wsj0 -ne=100 -lr=1e-4
    if [ ! $? == 0 ]; then exit; fi
fi

echo '5'
python main.py -i $SAVFILE -tl=128 -o $SAVFILE -ds=wsj0 -ne=100 -lr=3e-5 --no-valid-on-epoch
if [ ! $? == 0 ]; then exit; fi

echo '6'
python main.py -i $SAVFILE -tl=128 -o $SAVFILE -ds=wsj0 -ne=100 -lr=1e-5 --no-valid-on-epoch
if [ ! $? == 0 ]; then exit; fi

echo '7'
python main.py -i $SAVFILE -tl=256 -bs=16 -o $SAVFILE -ds=wsj0 -ne=100 -lr=3e-6 --no-valid-on-epoch
if [ ! $? == 0 ]; then exit; fi

echo '8'
python main.py -i $SAVFILE -tl=256 -bs=16 -o $SAVFILE -ds=wsj0 -ne=100 -lr=1e-6 --no-valid-on-epoch
if [ ! $? == 0 ]; then exit; fi

echo '9'
python main.py -i $SAVFILE -tl=512 -bs=8 -o $SAVFILE -ds=wsj0 -ne=100 -lr=5e-7 --no-valid-on-epoch
if [ ! $? == 0 ]; then exit; fi

echo '10'
python main.py -i $SAVFILE -tl=512 -bs=8 -o $SAVFILE -ds=wsj0 -ne=100 -lr=1e-7 --no-valid-on-epoch
