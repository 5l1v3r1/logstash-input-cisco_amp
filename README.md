# Logstash Cisco AMP Plugin

[![Gem Version](https://badge.fury.io/rb/logstash-input-cisco_amp.svg)](https://badge.fury.io/rb/logstash-input-cisco_amp)

This is an input plugin for the [Cisco AMP v1.0 API](https://api-docs.amp.cisco.com/api_resources?api_host=api.amp.cisco.com&api_version=v1) that ingests events into Logstash. This plugin has undergone limited testing but should be functional. Pull requests welcome.

## Plugin Parameters

* id - This is your Cisco AMP V1 API ID.
* key - This is your Cisco AMP V1 API Key.
* interval - Defines the amount of minutes to wait between each query to the AMP API.

## Installation

### Ruby Gems

```bash
gem install logstash-input-cisco_amp --platform=java
```

### Manual

```bash
cd /opt
git clone https://github.com/zaneGittins/logstash-input-cisco_amp
cd logstash-input-cisco_amp
gem build logstash-input-cisco_amp.gemspec
cd /usr/share/logstash
./bin/logstash-plugin install /opt/logstash-input-cisco_amp/logstash-input-cisco_amp-0.1.0.gem
```