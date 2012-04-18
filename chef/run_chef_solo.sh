#!/bin/sh

/var/lib/gems/1.8/bin/chef-solo -c config/solo.rb -j config/node.json
