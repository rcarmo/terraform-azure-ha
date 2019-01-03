# terraform-azure-ha

This is a demo plan to deploy a high-availability scenario using an Azure Standard Load Balancer and the [HA ports][haports] feature.

The full scenario has:

- two (nominally identical) servers on the same VNET
- an Azure Standard Load Balancer configured as an internal load balancer, also mapped to that VNET
- a test client machine (also on the same VNET) to issue requests to the load balancer


[haports]: https://docs.microsoft.com/en-us/azure/load-balancer/load-balancer-ha-ports-overview