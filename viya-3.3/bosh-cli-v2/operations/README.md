## Operations files

This folder contains [operations files](https://bosh.io/docs/cli-ops-files/) for
the deployment of SAS Viya 3.3 on CloudFoundry.

### Feature-based operations files

| Name | Purpose | Notes |
|:---  |:---     |:---   |
|[add-sas-programming.yml](add-sas-programming.yml) | Adds SAS Programming environment | Requires `sas.spawner.ip` property |
|[configure-db-ports.yml](configure-db-ports.yml)| Allows customization of PostgreSQL and PGPool ports | Requires `db.postgres.port` and `db.pgpool.port` properties |
|[enable-distributed-cas.yml](enable-distributed-cas.yml) | Converts CAS to a distributed model as opposed to one on a single machine | Requires `cas.worker.count` property |
|[enable-nfs.yml](enable-nfs.yml)| Enables NFS access for SAS and CAS | Requires `nfs.fstab` property |
|[enable-sssd.yml](enable-sssd.yml)| Enables SSSD host authentication access for SAS and CAS | Requires `sssd_conf` and `sssd_cert` property, typicall via --var-file |
|[programming-only.yml](programming-only.yml)| Configures only SAS, CAS, and SAS Studio for access | |
|[rename-default-network.yml](rename-default-network.yml)| Rename the default, network used by instances | Requires `default_network_name` property |
|[site-defaults.yml](site-defaults.yml)| Specify a default set of configuration to load into consul such as LDAP connectivity | Introduces [new variables](example-vars-files/vars-site-defaults.yml) |
|[use-vip-network.yml](use-vip-network.yml)| Add a VIP network to instances | Introduces [new variables](example-vars-files/vars-use-vip-network.yml) |

### CentOS stemcell operations files

SAS Viya supports running on CentOS stemcells in addition to Ubuntu. The
following operations files perform the necessary changes to your deployment
manifest.

| Name | Purpose | Notes |
|:---  |:---     |:---   |
|[add-sas-programming-centos.yml](add-sas-programming-centos.yml) | Adds SAS Programming environment for CentOS | Requires `sas.spawner.ip` property |
|[centos.yml](centos.yml) | Switches to CentOS stemcells and releases | |
|[enable-nfs-centos.yml](enable-nfs-centos.yml)| Enables NFS access for SAS and CAS on CentOS stemcells | Requires `nfs.fstab` property |
|[enable-sssd-centos.yml](enable-sssd-centos.yml)| Enables SSSD host authentication for SAS and CAS on CentOS stemcells | Requires `sssd_conf` and `sssd_cert` property, typically via --var-file |
