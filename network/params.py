import dpss

import sys
sys.path.append('../src/')

from application import Schnorr, TimeLock, DeadMan, FairExchange


# N = [4, 8, 16, 32, 64] # CONFIGURE
with open('/home/vamsi/extweexperiments/gcp/n', 'r') as f:
    N = [int(int(f.readline())/2)]
R = 1 # CONFIGURE
LOCAL = False # CONFIGURE
applications = [FairExchange] # CONFIGURE


T = [int(n / 2) for n in N]

old_addrs = None
new_addrs = None

if LOCAL:
    old_addrs = ['localhost' + ':' + str(50000 + n) for n in range(N[-1])]
    new_addrs = ['localhost' +  ':' + str(50000 + N[-1] + n) for n in range(N[-1])]
else:
    # read addresses from the file host_sockets. the first n/2 are old_addrs and the rest are new_addrs
    with open('../gcp/host_sockets', 'r') as f:
        addrs = f.readlines()
        old_addrs = addrs[:int(len(addrs) / 2)]
        new_addrs = addrs[int(len(addrs) / 2):]

    #old_addrs = ['node' + str(n) + ':' + '50050' for n in range(N[-1])]
    #new_addrs = ['node' + str(N[-1] + n) +  ':' + '50050' for n in range(N[-1])]
    # old_addrs = ['192.168.1.' + str(n + 1) + ':' + '50050' for n in range(N[-1])]
    # new_addrs = ['192.168.1.' + str(N[-1] + n + 1) +  ':' + '50050' for n in range(N[-1])]

resultsfile = 'experiment_results.txt'

PK = [dpss.setup(N[i], T[i]) for i in range(len(N))]




