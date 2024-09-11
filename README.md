# Distributed system simulation

The `main.rb` file simulates a network in which a shared state must be
achieved. The network consists in a group of nodes, all of which need to
register all state transactions as well as exchanged messages. In this
simulation the network exists as an underlying context in which all nodes
attempt to communicate.

## Nodes

* Each node has an unique identifier
* Each node is able to send and receive messages

## Consensus algorithm

The example implements the _raft_ algorith to achieve a shared state. In the
case of _follower_ nodes proposing state transactions, the proposing node must
make a request to the leader node for the proposal to start.

## Network

The network is able to simulate both node failures and network partitions

## Simulation CLI

To start the simulation execute `console` on a terminal

```bash
$ console
```
