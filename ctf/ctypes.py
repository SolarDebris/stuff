from ctypes import *


libc = CDLL("./libc.so.6")
rand = libc.rand()
srand = libc.srand()


def seed_srand(seed):
    srand(seed)

def generate_rand(num):
    rand_nums = []
    for i in range(num):
        rand_nums.append(rand())
    return rand_nums
