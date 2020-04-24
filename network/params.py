import dpss


N = [4, 8, 16, 32, 64, 128] # CONFIGURE
T = [int(n / 2) for n in N]
R = 10 # CONFIGURE

NSHOST = 'bulletin' # CONFIGURE
NSPORT = 9090

resultsfile = 'experiment_results.txt'

PK = [dpss.setup(N[i], T[i]) for i in range(len(N))]

THREADPOOL_SIZE = 2056

