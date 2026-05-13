# GPU Telemetry Layer

This document describes the GPU telemetry stack used by the Sanctuary Runtime
to monitor VRAM usage, GPU temperature, and compute utilization across the
multi-node cluster.

## Architecture

```
┌─────────────────────────────────────────────────────────┐
│  Cockpit Node (Prometheus Hub)                          │
│  ┌──────────────────┐  ┌──────────────────────────────┐ │
│  │  Prometheus       │  │  Grafana (optional)          │ │
│  │  :9090            │  │  :3000                       │ │
│  └────────┬─────────┘  └──────────────────────────────┘ │
│           │ scrapes                                      │
└───────────┼─────────────────────────────────────────────┘
            │
   ┌────────┴──────────────────────────────┐
   │                                       │
   ▼                                       ▼
┌──────────────────┐           ┌──────────────────────┐
│  EPYC Node        │           │  Threadripper Node    │
│  ┌─────────────┐ │           │  ┌─────────────────┐  │
│  │ DCGM Export │ │           │  │ DCGM Exporter   │  │
│  │ :9400        │ │           │  │ :9400            │  │
│  └─────────────┘ │           │  └─────────────────┘  │
│  ┌─────────────┐ │           │  ┌─────────────────┐  │
│  │ node-export │ │           │  │ node-exporter   │  │
│  │ :9100        │ │           │  │ :9100            │  │
│  └─────────────┘ │           │  └─────────────────┘  │
└──────────────────┘           └──────────────────────┘
```

## Components

### DCGM Exporter
- **What**: NVIDIA Data Center GPU Manager exporter for Prometheus.
- **Image**: `nvcr.io/nvidia/k8s/dcgm-exporter`
- **Port**: `9400`
- **Key metrics**:
  - `DCGM_FI_DEV_FB_USED` — framebuffer (VRAM) used in MiB
  - `DCGM_FI_DEV_FB_FREE` — framebuffer free in MiB
  - `DCGM_FI_DEV_GPU_TEMP` — GPU temperature in °C
  - `DCGM_FI_DEV_GPU_UTIL` — GPU utilization %
  - `DCGM_FI_DEV_POWER_USAGE` — power draw in W

### Prometheus Hub
- **What**: Central metrics collection and query engine.
- **Image**: `prom/prometheus`
- **Port**: `9090`
- **Config**: `prometheus.yml` (edit scrape targets there)

### Node Exporter (optional)
- **What**: CPU, memory, disk, and network metrics alongside GPU.
- **Image**: `prom/node-exporter`
- **Port**: `9100`

## Quickstart: GPU Node Setup

```sh
# 1. Install NVIDIA Container Toolkit (run once per node)
bash scripts/install-nvidia-container-toolkit.sh

# 2. Start the DCGM exporter on each GPU node
cd sanctuary-runtime/telemetry
docker compose -f docker-compose.dcgm-node.yml up -d

# 3. Verify metrics are being exported
curl -s http://localhost:9400/metrics | grep DCGM_FI_DEV_FB_USED
```

## Quickstart: Prometheus Hub Setup

```sh
# 1. Edit prometheus.yml — replace TODO-*-NODE-IP with real IPs
vim sanctuary-runtime/telemetry/prometheus.yml

# 2. Start the hub
cd sanctuary-runtime/telemetry
docker compose -f docker-compose.prometheus-hub.yml up -d

# 3. Open Prometheus UI
open http://localhost:9090
```

## VRAM Gate

The VRAM gate (`reviewer-vram-check.sh`) blocks agent operations when VRAM is
dangerously high.  See the Reviewer agent docs for how it integrates.

```sh
bash sanctuary-runtime/telemetry/reviewer-vram-check.sh
# exit 0 = safe
# exit 1 = VRAM or temp threshold exceeded
```

## Useful PromQL Queries

```promql
# VRAM usage % for all GPUs
(DCGM_FI_DEV_FB_USED / (DCGM_FI_DEV_FB_USED + DCGM_FI_DEV_FB_FREE)) * 100

# GPUs with VRAM > 80%
(DCGM_FI_DEV_FB_USED / (DCGM_FI_DEV_FB_USED + DCGM_FI_DEV_FB_FREE)) * 100 > 80

# GPU temperature
DCGM_FI_DEV_GPU_TEMP

# GPU utilization
DCGM_FI_DEV_GPU_UTIL
```

## Security Notes
- The Prometheus hub port (9090) should NOT be exposed to the public internet.
- DCGM node ports (9400, 9100) should only be reachable by the Prometheus hub.
- Use a firewall or Docker network policy to restrict access.

## TODO
- [ ] Add Grafana dashboard JSON for GPU overview
- [ ] Add alerting rules for VRAM > 80% and temp > 80°C
- [ ] Configure Prometheus remote_write for long-term storage (optional)
