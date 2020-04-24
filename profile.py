'''Experiment profile for cloudlab experiments'''

import geni.portal as portal
import geni.rspec.pg as pg

N = 16
NSHOST = 'bulletin'
NSPORT = 9090

# Create a portal context.
pc = portal.Context()

# Create a Request object to start building the RSpec.
request = pc.makeRequestRSpec()


M = 2 * N

''' Node Creation '''

# Create Nodes
nodes = []
for n in range(0, M):
    node = request.XenVM('node' + str(n))
    nodes += [node]


bulletin = request.XenVM(NSHOST)


''' Networking '''

# Link all nodes to each other
# for n in range(0, M):
#     for m in range(n + 1, M):
#         request.Link(members=[nodes[n], nodes[m]])

# for n in range(0, M):
#     request.Link(members=[nodes[n], bulletin])

request.Link(members=(nodes + [bulletin]))

    



''' VM SETUP '''

# Node Execute Scripts
for n in range(0, M):

    node = nodes[n]

    output = "/local/repository/startup_output.txt"

    nodehost = 'node' + str(n)

    i = 0
    if n >= N:
        i = 1
    j = n % N
    
    node.addService(pg.Execute(shell="sh", command="/local/repository/node.sh " + str(i) + ' ' + str(j) + ' ' + nodehost  + ' ' +  NSHOST + ' ' + str(NSPORT) + '>> ' + output))

# Bulletin Execute Scripts
bulletin.addService(pg.Execute(shell="sh", command="/local/repository/bulletin.sh" +  ' ' + NSHOST + ' ' + str(NSPORT) + '>> ' + output))

''' Print Resulting RSpec '''

pc.printRequestRSpec(request)
