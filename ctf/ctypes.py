from ctypes import *


libc = CDLL("./libc.so.6")
rand = libc.rand()
srand = libc.srand()
