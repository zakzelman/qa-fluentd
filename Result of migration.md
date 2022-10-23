# fluentd-deploy-qa
The first of all you need to make analyze work of fluentd on VM servers. Key moments is configs for all apps which helps collect logs from the fluent-bit. 
Fluent-bit is another service which helps to collect logs. But it just send through and nothing more. It translate them to the fluentd. And "fluentd" make filtration. Give a new tags, point on the another way, also divide on chunks for fast work in the Elastic Search, without this filtration we are get a problem like log lags.
