# README

> Best to use the [Justfile](https://github.com/casey/just) wrapper; other command runners are available. You can of course inspect the script to see what's going on, it's just bash.

# TLDR;

- `just ready`
- point your browser at http://localhost:9527 and login as admin/apachepulsar
    - a 'docker' environment should be available.


```
bsh ❯ just ready
[+] Running 6/10
 ⠙ Network pulsar_default      Created
 ⠙ Network pulsar_pulsar       Created 
 ⠙ Volume "pulsar_bookkeeper"  Created 
 ⠙ Volume "pulsar_zookeeper"   Created 
 ✔ Container docker_perms      Exited 
 ✔ Container pulsar_ui         Started
 ✔ Container zookeeper         Healthy
 ✔ Container pulsar-init       Exited
 ✔ Container bookie            Started
 ✔ Container broker            Started
Waiting for pulsar_ui to reach healthy
Waiting for pulsar_ui to reach healthy
Waiting for pulsar_ui to reach healthy
pulsar_ui is healthy
{"message":"Add super user success, please login"}
>>> Created User...
>>> Logged in...
{"message":"Add environment success"}
>>> Created Environment
http://localhost:9527 should now be configured ('admin/apachepulsar')
```