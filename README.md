# OpenPubSub
A cluster of free IPFS nodes with the PubSub API port open and for anyone to use.

### Endpoint
    nodes.openpubsub.com

### Website
http://openpubsub.com

## Python usage example
```python
# pip3 install py-ipfs-pubsub

import pubsub


# Topic specific callback
def on_sub_test(data,seqno,topic_ids,cid):

	print ("New Message:",cid)
	print (data)
	print ("")


# Subscribe - pubsub.sub(endpoint, topic, callback)
pubsub.sub("/dns/nodes.openpubsub.com/tcp/5001/http","mytopic",on_sub_test)

# Publish 10x
for i in range(10):
	# Publish - pubsub.pub(endpoint, topic, str/bytes message)
	pubsub.pub("/dns/nodes.openpubsub.com/tcp/5001/http","mytopic","Hello World!")
	input("")

# Unsubscribe from topic - pubsub.unsub(topic)
pubsub.unsub("mytopic")
```
