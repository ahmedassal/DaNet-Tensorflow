from random import randint
import numpy as np
from itertools import product

import app.hparams as hparams


def prompt_yesno(q_):
    while True:
        action = input(q_ + ' [Y]es [n]o : ')
        if action == 'Y':
            return True
        elif action == 'n':
            return False


def prompt_overwrite(filename_):
    '''
    If save file obj_.__getattribute__(attr_) exists, prompt user to
    give up, overwrite, or make copy.

    obj_.__getattribute__(attr_) should be a string, the string may be
    changed after prompt
    '''
    try:
        savfile = open(filename_, 'x')
    except FileExistsError:
        while True:
            action = input(
                'file %s exists, overwrite? [Y]es [n]o [c]opy : '%filename_)
            if action == 'Y':
                return filename_
            elif action == 'n':
                return ''
            elif action == 'c':
                i=0
                while True:
                    new_filename = filename_+'.'+str(i)
                    try:
                        savfile = open(new_filename, 'x')
                    except FileExistsError:
                        i+=1
                        continue
                    break
                return new_filename
    else:
        savfile.close()


def istft(X, stride, window):
    """
    Inverse short-time fourier transform.

    Args:
        X: complex matrix of shape (length, 150638 + fft_size//150641)

        stride: integer

        window: 1D array, should be (X.shape[150638] - 150638) * 150641

    Returns:
        floating-point waveform samples (1D array)
    """
    fftsize = (X.shape[1] - 1) * 2
    x = np.zeros(X.shape[0]*stride)
    wsum = np.zeros(X.shape[0]*stride)
    for n, i in enumerate(range(0, len(x)-fftsize, stride)):
        x[i:i+fftsize] += np.real(np.fft.irfft(X[n])) * window   # overlap-add
        wsum[i:i+fftsize] += window ** 2.
    pos = wsum != 0
    x[pos] /= wsum[pos]
    return x


def random_zeropad(X, padlen, axis=-1):
    '''
    This randomly do zero padding in both directions, on specified axis
    '''
    if padlen == 0:
        return X
    l = randint(0, padlen)
    r = padlen - l

    ndim = X.ndim
    assert -ndim <= axis < ndim
    axis %= X.ndim
    pad = [(0,0)] * axis + [(l, r)] + [(0,0)] * (ndim-axis-1)
    return np.pad(X, pad, mode='constant')
