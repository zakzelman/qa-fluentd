FROM alpine:3.13
LABEL maintainer "Fluentd developers <fluentd@googlegroups.com>"
LABEL Description="Fluentd docker image" Vendor="Fluent Organization" Version="1.14.1"

RUN apk add zlib-dev
RUN apk add openssl openssl-dev
RUN apk add librdkafka
RUN apk update && apk add bash
RUN apk add ruby-dev
RUN apk add make

RUN apk update \
 && apk add --no-cache \
        ca-certificates \
        ruby ruby-irb ruby-etc ruby-webrick \
        tini \
        build-base ruby-dev \
 && apk add --no-cache --virtual .build-deps \
        build-base linux-headers \
        ruby-dev gnupg \
 && gem install \
        ruby-kafka:0.7.10 \
        fluent-plugin-kafka:0.10.0 \
        fluent-plugin-prometheus:1.7.3 \
        fluent-plugin-prometheus_pushgateway:0.0.2 \
        fluent-plugin-kubernetes_metadata_filter:2.4.5 \
        fluent-plugin-concat:2.4.0 \
        fluent-config-regexp-type:1.0.0 \
        fluent-plugin-elasticsearch:4.0.7 \
        fluent-plugin-kubernetes_metadata_filter:2.4.5 \
        fluent-plugin-multiline-parser:0.1.1 \
        fluent-plugin-multi-format-parser:1.0.0 \
        fluent-plugin-record-modifier:2.1.0 \
        fluent-plugin-rewrite-tag-filter:2.2.0 \
        fluent-plugin-s3:1.3.0 \
        fluent-plugin-systemd:1.0.2 \
        fluent-plugin-td:1.1.0 \
        fluent-plugin-td-monitoring:0.2.4 \
        fluent-plugin-webhdfs:1.2.4 \
 && echo 'gem: --no-document' >> /etc/gemrc \
 && gem install \
        bundler \
        openssl:2.2.0 \
        oj:3.10.18 \
        json:2.4.1 \
        async-http:0.50.7 \
        ext_monitor:0.1.2 \
        fluentd:1.10.0 \
        bigdecimal:1.4.4 \
        fluent-logger:0.8.2 \
        addressable:2.7.0 \
        async:1.24.2 \
        async-io:1.27.6 \
        async-pool:0.2.0 \
        aws-eventstream:1.0.3 \
        aws-partitions:1.288.0 \
        aws-sdk-core:3.92.0 \
        aws-sdk-kms:1.30.0 \
        aws-sdk-s3:1.61.1 \
        aws-sdk-sqs:1.24.0 \
        aws-sigv4:1.1.1 \
        bundler:1.16.6 \
        concurrent-ruby:1.1.6 \
        console:1.8.2 \
        cool.io:1.6.0 \
        did_you_mean:1.1.0 \
        digest-crc:0.5.1 \
        domain_name:0.5.20190701 \
        elasticsearch:6.8.1 \
        elasticsearch-api:6.8.1 \
        elasticsearch-transport:6.8.1 \
        excon:0.73.0 \
        faraday:0.17.3 \
        ffi:1.12.2 \
        ffi-compiler:1.0.1 \
        hirb:0.7.3 \
        http:4.4.1 \
        http-accept:1.7.0 \
        http-cookie:1.0.3 \
        http-form_data:2.3.0 \
        http-parser:1.2.1 \
        http_parser.rb:0.6.0 \
        httpclient:2.8.2.4 \
        io-console \
        ipaddress:0.8.3 \
        jmespath:1.4.0 \
        kubeclient:4.6.0 \
        lru_redux:1.1.0 \
        ltsv:0.1.2 \
        mime-types:3.3.1 \
        mime-types-data:3.2019.1009 \
        mini_portile2:2.4.0 \
        minitest:5.10.1 \
        mixlib-cli:1.7.0 \
        mixlib-config:2.2.4 \
        mixlib-log:1.7.1 \
        mixlib-shellout:2.2.7 \
        msgpack:1.3.3 \
        multi_json:1.14.1 \
        multipart-post:2.1.1 \
        net-telnet:0.1.1 \
        netrc:0.11.0 \
        nio4r:2.5.2 \
        nokogiri:1.10.9 \
        ohai:6.20.0 \
        parallel:1.19.1 \
        power_assert:0.4.1 \
        prometheus-client:0.9.0 \
        protocol-hpack:1.4.2 \
        protocol-http:0.15.1 \
        protocol-http1:0.10.3 \
        protocol-http2:0.11.6 \
        psych \
        public_suffix:4.0.3 \
        quantile:0.2.1 \
        rake:13.0.3 \
        rdkafka:0.10.0 \
        rdoc \
        recursive-open-struct:1.1.1 \
        rest-client:2.1.0 \
        ruby-progressbar:1.10.1 \
        rubyzip:1.3.0 \
        serverengine:2.2.1 \
        sigdump:0.2.4 \
        strptime:0.2.3 \
        systemd-journal:1.3.3 \
        systemu:2.5.2 \
        td:0.16.8 \
        td-client:1.0.7 \
        td-logger:0.3.27 \
        test-unit:3.2.3 \
        thread_safe:0.3.6 \
        timers:4.3.0 \
        tzinfo:2.0.1 \
        tzinfo-data:1.2019.3 \
        unf:0.1.4 \
        unf_ext:0.0.7.7 \
        webhdfs:0.9.0 \
        xmlrpc:0.2.1 \
        yajl-ruby:1.4.1 \
        zip-zip:0.3 \


# NOTE: resolv v0.2.1 includes the fix for CPU spike issue due to DNS resolver.
# This hack is needed for Ruby 2.6.7, 2.7.3 and 3.0.1. (alpine image is still kept on 2.7.3)
        resolv:0.2.1 --ignore-dependencies \

 && apk del .build-deps \
 && rm -rf /tmp/* /var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem /usr/lib/ruby/gems/2.*/gems/fluentd-*/test

RUN addgroup -S fluent && adduser -S -g fluent fluent \
    # for log storage (maybe shared with host)
    && mkdir -p /usr/share/fluentd/log \
    # configuration/plugins path (default: copied from .)
    && mkdir -p /usr/share/fluentd/etc \
    && mkdir -p /usr/share/fluentd/plugins \
    && mkdir -p /usr/share/bin \
    && chown -R fluent /usr/share/fluentd && chgrp -R fluent /usr/share/fluentd && chown -R fluent /usr/share/ \
    && chmod -R 770 /usr/share/bin/


COPY fluent.conf /usr/share/bin/
COPY entrypoint.sh /usr/share/bin/


ENV FLUENTD_CONF="fluent.conf"

ENV LD_PRELOAD=""
# NOTE: resolv v0.2.1 includes the fix for CPU spike issue due to DNS resolver.
# Forcing to load specific version of resolv (instead of bundled by default) is needed for Ruby 2.6.7, 2.7.3 and 3.0.1.
# alpine image is still kept on 2.7.3. See https://pkgs.alpinelinux.org/packages?name=ruby&branch=v3.13
ENV RUBYLIB="/usr/lib/ruby/gems/2.7.0/gems/resolv-0.2.1/lib"


USER root
ENTRYPOINT ["tini",  "--", "/usr/share/bin/entrypoint.sh"]
CMD ["fluentd"]
