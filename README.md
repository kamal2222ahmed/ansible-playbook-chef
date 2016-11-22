# ansible-playbook-chef
An ansible playbook POC to perform [chef-client](https://docs.chef.io/ctl_chef_client.html#run-in-local-mode) in clusters of servers.

## Rationale
This is a very strange use case for chef client, it was devised to meet the following requirements:
* Chef converge on multiple copies of the same cluster:
    * All cluster instances have the same chef certificates
    * All cluster instances share the same ips (i.e. each member server has the same ip in each cluster)
    * All cluster instances potentially require separate configurations (i.e. dev, staging, prod)
* Scheme must be able to perform periodic updates
* Scheme must be able to perform triggered updates through common CI tools
* Scheme must be fully declarative (i.e. playbook repo is only source of truth)

## Dependencies
All python runtime and testing dependencies are listed in requirements.txt. Install with `pip install --upgrade -r requirements.txt`

## Extending
* To add chef cookbook 'cb01' to the repo, append fragment `cookbook 'cb01'` to the repo's [Berkshelf file](/assets/chef-repo/Berksfile)
* To add chef role 'x' to the repo, create a chef role file in the repo's [role directory](/assets/chef-repo/roles) such as the following:
    ```
    name 'x'
    description 'configuration for clsuterx nodes'
    run_list "recipe[cb01]"
    ```
* To add an additional server cluster with name 'clusterx', role 'x' and members 'server-x01' and 'server-x02':
    * Add file clusterx to the [inventory](/inventory) with the following contents:
    ```
    [clusterx]
    server-x01
    server-x02

    [clusterx:vars]
    role=x
    ```
    * Add entry `clusterx` to the `[chef:children]` section of the [chef inventory file](/inventory/chef) :
    * Add file clusterx to the [test inventory](/test/inventory) with the following contents:
    ```
    [clusterx]
    
    server-x02

    [clusterx:vars]
    role=x
    ```
    * Add entry `clusterx` to the `[chef:children]` section of the [molecule test inventory file](/test/inventory/molecule)


## Testing
Run `paver test` to perform a test. You will need docker running on your test machine.

## Running
Run `paver chef` to perform a live run and 

## To Do
* Extend playbook with [bastion hosts](http://blog.scottlowe.org/2015/12/24/running-ansible-through-ssh-bastion-host/) for each environment
* Look into splitting the [chef repo](/assets/chef-repo) into a separate repository and leverage branches for differentiated configuration of different environments
* Look into splitting this repo into separate branches for differentiated configuration of different environments
* Build CI configuration POC
