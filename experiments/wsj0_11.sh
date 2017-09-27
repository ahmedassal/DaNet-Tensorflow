#!/bin/bash
SAVFILE='saves/wsj0_1.ckpt'
if [ ! -e $SAVFILE ]; then
    python main.py -o $SAVFILE -tl=64 -ds=wsj0 -ne=10 --no-valid-on-epoch
    if [ ! $? == 0 ]; then exit; fi
    python main.py -ds=wsj0 -i $SAVFILE -m=debug
    python main.py -i $SAVFILE -tl=64 -o $SAVFILE -ds=wsj0 -ne=100 -lr=3e-4 --no-valid-on-epoch
    if [ ! $? == 0 ]; then exit; fi
    python main.py -i $SAVFILE -tl=64 -o $SAVFILE -ds=wsj0 -ne=100 -lr=1e-4 --no-valid-on-epoch
    if [ ! $? == 0 ]; then exit; fi
fi

python main.py -i $SAVFILE -tl=128 -o $SAVFILE -ds=wsj0 -ne=100 -lr=3e-5 --no-valid-on-epoch
if [ ! $? == 0 ]; then exit; fi

python main.py -i $SAVFILE -tl=128 -o $SAVFILE -ds=wsj0 -ne=100 -lr=1e-5 --no-valid-on-epoch
if [ ! $? == 0 ]; then exit; fi

python main.py -i $SAVFILE -tl=256 -bs=16 -o $SAVFILE -ds=wsj0 -ne=100 -lr=3e-6 --no-valid-on-epoch
if [ ! $? == 0 ]; then exit; fi

python main.py -i $SAVFILE -tl=256 -bs=16 -o $SAVFILE -ds=wsj0 -ne=100 -lr=1e-6 --no-valid-on-epoch
if [ ! $? == 0 ]; then exit; fi

python main.py -i $SAVFILE -tl=512 -bs=8 -o $SAVFILE -ds=wsj0 -ne=100 -lr=5e-7 --no-valid-on-epoch
if [ ! $? == 0 ]; then exit; fi

python main.py -i $SAVFILE -tl=512 -bs=8 -o $SAVFILE -ds=wsj0 -ne=100 -lr=1e-7 --no-valid-on-epoch
