import subprocess
import os

# extract GPU available mem
f = os.popen("lshw -c display | grep clock")
gpu_freq = f.read()
gpu_freq = gpu_freq.split()
gpu_freq = gpu_freq[1]
print(gpu_freq)