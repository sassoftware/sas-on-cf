# BOSH CLI v2 Samples

This directory contains manifests for use by BOSH CLI v2 for deployment of SAS
Viya 3.3.

# Deploying SAS Viya

Much of the existing [deployment guide](http://go.documentation.sas.com/?cdcId=calcdc&cdcVersion=3.3&docsetId=dplyml0cld&docsetTarget=titlepage.htm&locale=en)
is still valid when using the BOSH CLI v2. This document focuses on the
differences related to the deployment manifest and operations files themselves.

## System Requirements

The SAS Viya deployment manifest makes use of specific `vm_type` and
`persistent_disk_type` values. These names should exist in your BOSH director's
cloud configuration or be changed via a custom operations file.

### Virtual Machine Specifications

| Name | CPUs | RAM (MiB) |
|:---  |:---  |:---   |
| minimal | 2 | 4096
| small | 4 | 4096 |
| large | 4 | 8192 |
| cas | 4 | 8192 |

### Disk Specifications

| Name |
|:---  |
| 5GB |
| 10GB |
| 50GB |

### Standard Properties

The SAS Viya deployment manifest makes use of several property substitutions for
the purposes of configuration. BOSH's --vars-store feature is used to generate
strong passwords and tokens.  There are no default credentials for servers
deployed via this mechanism.

| Name | Description | Notes |
|:---  |:---         |:---   |
|sas_setinit_text| Provides the license information for SAS and CAS | --var-file sas_setinit_text=path/to/setinit.sas |
|consul.ips| Allows consul agents to know the server cluster join addresses | These can be BOSH DNS names. |
|consul.ip| Allows applications in the application runtime to connect to consul | This network address must be resolvable from the application runtime. |

Additionally, the SAS Viya deployment includes both BOSH-managed VMs and
applications deployed to the Cloud Foundry application runtime. There are
several [properties](operations/example-vars-files/vars-deployment.yml) required
for this step.

### Network Communication

As noted previously, SAS Viya includes software deployed to BOSH-managed VMs:
SAS, CAS, Consul, PostgreSQL, etc., as well as applications deployed to the
Cloud Foundry application runtime. The applications deployed in application
runtime must be able to establish a network connection with those deployed as
BOSH-managed VMs. Ensure that your BOSH director network definitions and their
use in the deployment manifest support these connectivity requirements.

By providing the Consul address to the application runtime components, they will
be able to lookup the location of the other BOSH-managed VMs via Consul service
registrations.

## Common Manifest and Operations File Examples

### Default Visual Interfaces Deployment

This default deployment deploys the visual interfaces with a single `sasboot` userid.

```
bosh -e my-env -d sas-vdmml interpolate deployment-manifest.yml \
  --vars-store creds.yml \
  --vars-file deployment-vars.yml \
  --var-file sas_setinit_text=path/to/setinit.sas \
  > rendered-manifest.yml
```

### Visual Interfaces with LDAP-backed authentication

The SAS Viya visual interfaces can be configured to use an LDAP server for
authentication. By adding the site-defaults.yml operations file and defining the
appropriate properties, this deployment will enable that functionality.

```
bosh -e my-env -d sas-vdmml interpolate deployment-manifest.yml \
  --vars-store creds.yml \
  --vars-file deployment-vars.yml \
  --var-file sas_setinit_text=path/to/setinit.sas \
  -o operations/site-defaults.yml \
  > rendered-manifest.yml
```

### Visual Interfaces + Programming Interface Deployment

The SAS programming environment utilizes host-based authentication for access to
the SAS Studio web application. SAS provides a generic SSSD release which
delivers the necessary SSSD libraries and allows for setting the configuration
files.

```
bosh -e my-env -d sas-vdmml interpolate deployment-manifest.yml \
  --vars-store creds.yml \
  --vars-file deployment-vars.yml \
  --var-file sas_setinit_text=path/to/setinit.sas \
  --var-file sssd_conf=path/to/sssd.conf \
  --var-file sssd_cert=path/to/sssd.cert \
  -o operations/enable-sssd.yml \
  -o operations/add-sas-programming.yml \
  > rendered-manifest.yml
```

### Programming Interface Only Deployment

The SAS programming environment utilizes host-based authentication for access to
the SAS Studio web application. SAS provides a generic SSSD release which
delivers the necessary SSSD libraries and allows for setting the configuration
files.

```
bosh -e my-env -d sas-vdmml interpolate deployment-manifest.yml \
  --vars-store creds.yml \
  --vars-file deployment-vars.yml \
  --var-file sas_setinit_text=path/to/setinit.sas \
  --var-file sssd_conf=path/to/sssd.conf \
  --var-file sssd_cert=path/to/sssd.cert \
  -o operations/enable-sssd.yml \
  -o operations/add-sas-programming.yml \
  -o operations/programming-only.yml \
  > rendered-manifest.yml
```

### Deploying the Software

Once interpolated, you can use BOSH to deploy the managed VMs and push
applications to the Cloud Foundry application runtime.

```
bosh -e my-env -d sas-vdmml deploy rendered-manifest.yml && \
  bosh run errand microservices
```
