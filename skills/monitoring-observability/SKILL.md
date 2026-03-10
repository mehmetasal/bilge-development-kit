---
name: monitoring-observability
description: Production monitoring, logging, tracing, alerting, and observability patterns. Covers structured logging, distributed tracing, metrics collection, and incident alerting.
---

# Monitoring & Observability Skill

Patterns and best practices for making production systems observable and debuggable.

## Three Pillars of Observability

| Pillar | Purpose | Tools |
|--------|---------|-------|
| **Logs** | What happened (events) | Pino, Winston, Python logging |
| **Metrics** | How much/how fast (numbers) | Prometheus, Datadog, CloudWatch |
| **Traces** | Request flow across services | OpenTelemetry, Jaeger, Zipkin |

---

## Structured Logging

### Principles

| Principle | Rule |
|-----------|------|
| **Always structured** | JSON format, never plain text in production |
| **Always contextual** | Include requestId, userId, service name |
| **Never sensitive** | No passwords, tokens, PII in logs |
| **Appropriate levels** | ERROR=broken, WARN=degraded, INFO=business events, DEBUG=dev only |

### Log Levels

| Level | When to Use | Example |
|-------|-------------|---------|
| **ERROR** | Something is broken, needs attention | DB connection failed, unhandled exception |
| **WARN** | Degraded but functional | Retry succeeded, cache miss, slow query |
| **INFO** | Business-significant events | User registered, order placed, deploy complete |
| **DEBUG** | Development troubleshooting | Function input/output, state changes |

### What to Log

| Always Log | Never Log |
|------------|-----------|
| Request start/end with duration | Passwords or tokens |
| Error with stack trace | Full credit card numbers |
| Business events (signup, purchase) | PII without anonymization |
| External API calls with latency | Health check successes (too noisy) |
| Deployment events | Debug logs in production |

### Structured Log Format

```json
{
  "timestamp": "2025-03-05T10:30:00.000Z",
  "level": "error",
  "service": "api",
  "requestId": "req_abc123",
  "userId": "usr_456",
  "message": "Payment processing failed",
  "error": {
    "name": "PaymentError",
    "message": "Card declined",
    "code": "CARD_DECLINED"
  },
  "duration_ms": 1250,
  "metadata": {
    "provider": "stripe",
    "amount": 9900
  }
}
```

---

## Metrics

### Key Metrics (RED Method for Services)

| Metric | What | Alert When |
|--------|------|------------|
| **Rate** | Requests per second | Sudden drop (outage) or spike (attack) |
| **Errors** | Error rate (%) | > 1% of requests |
| **Duration** | Latency (P50, P95, P99) | P95 > 2x normal |

### Key Metrics (USE Method for Resources)

| Metric | What | Alert When |
|--------|------|------------|
| **Utilization** | % resource in use | CPU > 80%, Memory > 85%, Disk > 90% |
| **Saturation** | Queue depth, waiting | Queue growing, not draining |
| **Errors** | Resource errors | Disk I/O errors, OOM kills |

### Business Metrics

| Metric | Purpose |
|--------|---------|
| Signups per hour | Growth monitoring |
| Conversion rate | Business health |
| Revenue per minute | Revenue monitoring |
| Active users | Engagement tracking |

---

## Alerting

### Alert Design Principles

| Principle | Rule |
|-----------|------|
| **Actionable** | Every alert must have a runbook or clear action |
| **No noise** | If you ignore it, it shouldn't be an alert |
| **Tiered severity** | Page for critical, Slack for warning, email for info |
| **Include context** | Alert must contain enough info to start investigating |

### Alert Severity

| Severity | Channel | Response Time | Example |
|----------|---------|---------------|---------|
| **Critical** | PagerDuty / Phone | < 5 min | Service down, data loss risk |
| **High** | Slack #alerts | < 30 min | Error rate > 5%, high latency |
| **Warning** | Slack #monitoring | < 4 hours | Disk 80%, slow queries |
| **Info** | Dashboard only | Next business day | Deployment complete |

### Anti-patterns

| Anti-Pattern | Problem |
|-------------|---------|
| Alert on every error | Alert fatigue, people ignore |
| No runbook | Responder doesn't know what to do |
| Alert on symptom only | Need to understand cause |
| Static thresholds only | Misses anomalies, triggers on normal variation |

---

## Health Checks

### Types

| Type | Purpose | Frequency |
|------|---------|-----------|
| **Liveness** | "Is the process running?" | Every 10s |
| **Readiness** | "Can it serve traffic?" | Every 5s |
| **Startup** | "Has it finished initializing?" | During boot |
| **Deep health** | "Are all dependencies OK?" | Every 30s |

### Health Check Response

```json
{
  "status": "healthy",
  "version": "1.2.3",
  "uptime_seconds": 86400,
  "checks": {
    "database": { "status": "healthy", "latency_ms": 5 },
    "redis": { "status": "healthy", "latency_ms": 2 },
    "external_api": { "status": "degraded", "latency_ms": 1500 }
  }
}
```

---

## Distributed Tracing (OpenTelemetry)

### When to Use

| Scenario | Need Tracing? |
|----------|--------------|
| Single service | Usually no, logs sufficient |
| 2-3 services | Helpful for debugging |
| Microservices (4+) | Essential |
| Async workflows | Essential |

### Trace Context Propagation

```
Client -> API Gateway -> Auth Service -> User Service -> Database
  |           |              |               |             |
  trace_id: abc-123 (same across all services)
  span_id:  unique per service call
```

---

## Dashboard Design

### Essential Dashboards

| Dashboard | Contents |
|-----------|----------|
| **Service Overview** | Request rate, error rate, latency (RED) |
| **Infrastructure** | CPU, memory, disk, network (USE) |
| **Business** | Signups, conversions, revenue |
| **Deployment** | Deploy frequency, rollback rate, lead time |

### Dashboard Principles

- **Start with the user experience** (latency, errors)
- **Drill down from overview to detail**
- **Time-series graphs for trends**
- **Counters for current state**
- **Red/yellow/green for status at a glance**

---

## Stack Recommendations (2025)

| Need | Self-Hosted | Managed |
|------|-------------|---------|
| Logging | ELK Stack, Loki | Datadog, Logtail |
| Metrics | Prometheus + Grafana | Datadog, CloudWatch |
| Tracing | Jaeger, Tempo | Datadog, Honeycomb |
| Alerting | Alertmanager | PagerDuty, OpsGenie |
| All-in-one | Grafana Stack | Datadog, New Relic |
| Error tracking | Sentry (self-host) | Sentry, Bugsnag |

---

## Review Checklist

- [ ] Structured JSON logging configured
- [ ] Request ID propagated across all services
- [ ] No sensitive data in logs
- [ ] Health check endpoint implemented
- [ ] Key metrics (RED/USE) being collected
- [ ] Alerts are actionable with runbooks
- [ ] Error tracking service configured (e.g. Sentry)
- [ ] Dashboards for service overview exist
- [ ] Log retention policy defined
- [ ] Tracing enabled (if multi-service)
