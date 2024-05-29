# YACE Exporter

- Upstream docs: [https://github.com/prometheus/cloudwatch_exporter](https://github.com/nerdswords/yet-another-cloudwatch-exporter)

## Features

- Exports AWS YACE metrics to Prometheus
- Easy to configure using a YAML configuration file

## How to reach parity with AWS CW Exporter on Prometheus

To reach parity with AWS CloudWatch Exporter on Prometheus, you can use the following `metric_relabel_configs` configuration in your Prometheus YAML file:

```yaml
metric_relabel_configs:
  - regex: dimension_(.*)
    action: labelmap
    replacement: '${1}'
  - regex: dimension_(.*)
    action: labeldrop
  - regex: tag_(.*)
    action: labelmap
    replacement: '${1}'
  - regex: tag_(.*)
    action: labeldrop
  - regex: custom_tag_(.*)
    action: labelmap
    replacement: '${1}'
  - regex: custom_tag_(.*)
    action: labeldrop
