# Mastodon RSS World stack module

Content-only Platform Zero module providing curated world-news feeds and Mastodon bootstrap follows to `mastodon-rss-publisher`.

## Validation

```sh
../sso-stack-generator/scripts/test-module.sh --all .
```

The reviewed feed definition and matching bootstrap-follow list are overlaid into the stack. This module has no standalone service; deployed behavior is verified through the publisher.

