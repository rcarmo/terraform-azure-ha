# terraform-azure-ha

This is a demo plan to deploy a high-availability scenario using an Azure Standard Load Balancer and the [HA ports][haports] feature.

The full scenario has:

- two (nominally identical) back-end servers on the same VNET and subnet
- an Azure Standard Load Balancer configured as an internal load balancer, also mapped to that VNET
- a test client machine (also on the same VNET, but another subnet) to issue requests to the load balancer
- an HTTP probe defined to ascertain service health

## Notes:

* Resource naming and tagging conventions should be revised depending on your operational practices (since I build reference architectures for multiple customers, I tend to vary a little across examples).
* All machines are provisioned with public IP addresses _as a convenience for testing_. These should be removed for any production use that does not require them.
* The same configuration can be put together with Windows machines (you need to supply your own VM definitions)

[haports]: https://docs.microsoft.com/en-us/azure/load-balancer/load-balancer-ha-ports-overview