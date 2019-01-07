# terraform-azure-ha

This is a demo plan to deploy a high-availability scenario using an Azure Standard Load Balancer and the [HA ports][haports] feature.

The full scenario has:

- two (nominally identical) back-end servers on the same VNET and subnet, running a small HTTP server that returns their hostname when you issue a request for `/hostname`
- an Azure Standard Load Balancer configured as an internal load balancer, also mapped to that VNET, with an HA rule for those servers and an HTTP probe defined to ascertain service health
- a test client machine (also on the same VNET, but another subnet) to issue requests to the load balancer

## Usage

* Boostrap your environment by cloning this repository and doing `make init`.
* Apply this plan using `make apply` and SSH into the client machine (the `Makefile` automatically adds your SSH key to all the servers if you're using Linux or Mac). 
* Make a note of the load balancer's IP address (typically 10.0.0.4) and run `watch curl -s http://10.0.0.4/hostname`

You should see something like this:

```
Every 2.0s: curl -s http://10.0.0.4/hostname                             client: Mon Jan  7 15:31:53 2019

sv-backend1
```

That means the load balancer considers the first backend as being the primary destination for traffic.

* Go to the portal and kill backend 1. The `curl` output should change to backend 2
* Restart backend 1. Wait a few seconds for health probes to recognize it's active, but there should be no change in `curl` output
* Kill backend 2. Traffic should move to backend 1 again

## Notes:

* Resource naming and tagging conventions should be revised depending on your operational practices (since I build reference architectures for multiple customers, I tend to vary a little across examples).
* All machines are provisioned with public IP addresses _as a convenience for testing_. These should be removed for any production use that does not require them.
* The same configuration can be put together with Windows machines (you need to supply your own VM definitions)

[haports]: https://docs.microsoft.com/en-us/azure/load-balancer/load-balancer-ha-ports-overview