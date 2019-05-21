Lightweight python tool for interacting with a collection of coda daemons.

**Inputs:** Ansible inventory list

**Actions:** gather status info, gather crash data, gather and collect logs

**Method:** Uses [Fabric](http://www.fabfile.org/) 

**Why:** Equivalent flows using ansible were too cumbersome and slow (running ansible playbooks, parsing intermedite scripts)
