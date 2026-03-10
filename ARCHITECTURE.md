# Bilge Development Kit (BDK) Architecture

> Comprehensive AI Agent Capability Expansion Toolkit for Claude Code & Gemini

---

## Overview

Bilge Development Kit is a modular system consisting of:

- **22 Specialist Agents** - Role-based AI personas
- **56 Core Skills** - Domain-specific knowledge modules
- **37 Extra Skills** - Niche/framework-specific modules (optional)
- **15 Workflows** - Slash command procedures
- **5 Scripts** - Automation and validation tools
- **4 Hooks** - Automated guardrails (secret scanning, dangerous cmd detection)
- **5 Rules** - Always-on coding standards
- **3 Contexts** - Mode-specific behavior (dev, review, research)

---

## Directory Structure

```plaintext
.agent/
├── ARCHITECTURE.md          # This file
├── README.md                # Project documentation
├── mcp_config.json.example  # MCP configuration example
├── .gitignore               # Git ignore rules
├── .shared/                 # Shared assets across skills
│   └── ui-ux-pro-max/      # Shared UI/UX resources
├── agents/                  # 22 Specialist Agents
├── skills/                  # 56 Core Skills (agent-referenced)
├── skills-extra/            # 37 Extra Skills (niche/optional)
├── workflows/               # 15 Slash Commands
├── rules/                   # Global Rules + Always-On Standards
│   ├── CLAUDE.md            # Claude Code protocol rules
│   ├── GEMINI.md            # Gemini protocol rules
│   └── common/              # Always-on coding standards
│       ├── git-workflow.md  # Commit format, branch naming, PR rules
│       ├── coding-style.md  # Naming conventions, file organization
│       ├── testing.md       # Test requirements, AAA pattern, coverage
│       ├── security.md      # Secrets, input validation, OWASP
│       └── performance.md   # Core Web Vitals, bundle size, caching
├── contexts/                # Mode-specific behavior contexts
│   ├── dev.md               # Development mode
│   ├── review.md            # Code review mode
│   └── research.md          # Research/analysis mode
├── scripts/                 # 5 Automation Scripts
│   ├── hooks/               # Hook scripts (guardrails)
│   │   ├── dangerous_cmd_check.sh  # Block destructive commands
│   │   ├── secret_scanner.sh       # Detect hardcoded secrets
│   │   ├── lint_check.sh           # Post-edit lint verification
│   │   └── session_save.sh         # Session context persistence
│   ├── detect_pm.py         # Package manager auto-detection
│   ├── checklist.py         # Priority-based validation
│   ├── verify_all.py        # Comprehensive verification
│   ├── auto_preview.py      # Dev server management
│   └── session_manager.py   # Project state analysis
└── .claude/
    ├── settings.json        # Hooks configuration
    └── skills/              # 13 Workflow Skills (Claude Code format)

```

---

## Agents (22)

Specialist AI personas for different domains.

| Agent                    | Focus                              |
| ------------------------ | ---------------------------------- |
| `orchestrator`           | Multi-agent coordination           |
| `project-planner`        | Discovery, task planning           |
| `frontend-specialist`    | Web UI/UX                          |
| `backend-specialist`     | API, business logic                |
| `database-architect`     | Schema, SQL, migrations            |
| `mobile-developer`       | React Native, Flutter              |
| `game-developer`         | Game logic, engines, mechanics     |
| `ai-engineer`            | AI/ML, LLM, RAG, agents           |
| `data-engineer`          | ETL, pipelines, analytics          |
| `devops-engineer`        | CI/CD, Docker, production ops      |
| `security-auditor`       | OWASP, supply chain, zero trust    |
| `penetration-tester`     | Offensive security, exploitation   |
| `test-engineer`          | Testing, TDD, coverage             |
| `qa-automation-engineer` | E2E testing, Playwright, CI        |
| `debugger`               | Root cause analysis, crash investigation |
| `performance-optimizer`  | Speed, Web Vitals, profiling       |
| `seo-specialist`         | Ranking, visibility, SEO           |
| `documentation-writer`   | Technical docs, manuals            |
| `product-owner`          | Strategy, backlog, MVP, requirements |
| `api-designer`           | REST, GraphQL, gRPC API design     |
| `code-archaeologist`     | Legacy code, refactoring           |
| `explorer-agent`         | Codebase discovery, deep analysis  |

---

## Skills

### Core Skills (56)

Skills actively referenced by agents. Loaded on-demand based on task context.

#### Backend & API

| Skill                              | Description                                      |
| ---------------------------------- | ------------------------------------------------ |
| `api-patterns`                     | REST, GraphQL, tRPC design principles            |
| `api-security-best-practices`      | API auth, validation, rate limiting              |
| `backend-dev-guidelines`           | Node.js + Express + TypeScript standards         |
| `nodejs-best-practices`            | Node.js async, error handling, security          |

#### Frontend & UI

| Skill                   | Description                                                 |
| ----------------------- | ----------------------------------------------------------- |
| `frontend-design`       | UI/UX patterns, design systems, component architecture      |
| `react-best-practices`  | React/Next.js performance, hooks, state management          |
| `tailwind-patterns`     | Tailwind CSS utilities, responsive design, themes           |
| `web-design-guidelines` | Responsive design, accessibility (WCAG), web performance    |

#### Database

| Skill             | Description                               |
| ----------------- | ----------------------------------------- |
| `database-design` | Schema design, indexing, migrations       |

#### Python

| Skill                    | Description                                 |
| ------------------------ | ------------------------------------------- |
| `python-patterns`        | Python standards, async, type hints         |
| `python-packaging`       | Package distribution, PyPI publishing       |
| `python-testing-patterns`| pytest, fixtures, mocking, TDD             |

#### DevOps & Infrastructure

| Skill                              | Description                              |
| ---------------------------------- | ---------------------------------------- |
| `deployment-procedures`            | CI/CD, GitOps, rollback strategies       |
| `deployment-validation-config-validate` | Configuration validation and testing |
| `devops-troubleshooter`            | Rapid incident troubleshooting           |
| `server-management`               | Process management, monitoring, scaling  |
| `monitoring-observability`        | Logging, tracing, alerting, SLI/SLO      |
| `secrets-management`              | Vault, AWS Secrets Manager, CI/CD secrets|

#### Testing & Quality

| Skill                          | Description                            |
| ------------------------------ | -------------------------------------- |
| `testing-patterns`             | Unit, integration, mocking strategies  |
| `webapp-testing`               | Playwright, Cypress, visual regression |
| `tdd-workflow`                 | Test-Driven Development cycle          |
| `code-review-checklist`        | Comprehensive code review standards    |
| `code-reviewer`                | AI-powered code review                 |
| `lint-and-validate`            | Linting, static analysis, formatting   |
| `unit-testing-test-generate`   | Comprehensive unit test generation     |
| `verification-before-completion` | Verify before claiming work done     |

#### Security

| Skill                   | Description                             |
| ----------------------- | --------------------------------------- |
| `vulnerability-scanner` | SAST/DAST, dependency auditing, CVE     |
| `red-team-tactics`      | Offensive security, penetration testing |

#### Architecture & Planning

| Skill                          | Description                              |
| ------------------------------ | ---------------------------------------- |
| `app-builder`                  | Full-stack scaffolding, monorepo setup   |
| `architecture`                 | System design, DDD, clean architecture   |
| `architecture-decision-records`| ADR documentation                        |
| `plan-writing`                 | Structured task planning, breakdowns     |
| `brainstorming`                | Socratic questioning, design review      |

#### Code Quality & Refactoring

| Skill                              | Description                               |
| ---------------------------------- | ----------------------------------------- |
| `clean-code`                       | Clean Code principles (Robert C. Martin)  |
| `refactoring-patterns`             | Extract method, strategy, strangler fig   |
| `code-refactoring-tech-debt`       | Technical debt identification, prioritization |
| `codebase-cleanup-deps-audit`     | Dependency security, license compliance   |

#### Documentation

| Skill                              | Description                               |
| ---------------------------------- | ----------------------------------------- |
| `documentation-templates`          | README, API docs, code comment formats    |
| `code-documentation-code-explain`  | Code explanation with diagrams            |
| `code-documentation-doc-generate`  | Auto-generate docs from code              |
| `readme`                           | README.md creation and updates            |
| `writing-skills`                   | Creating and editing BDK skills           |

#### Mobile & Game

| Skill              | Description                               |
| ------------------ | ----------------------------------------- |
| `mobile-design`    | Mobile UI/UX, iOS HIG, Material Design    |
| `game-development` | Game architecture, engines, mechanics     |

#### SEO & Growth

| Skill              | Description                           |
| ------------------ | ------------------------------------- |
| `seo-fundamentals` | SEO, meta tags, structured data       |
| `geo-fundamentals` | Generative Engine Optimization (GEO)  |

#### Shell/CLI

| Skill                  | Description                    |
| ---------------------- | ------------------------------ |
| `bash-linux`           | Linux commands, scripting      |
| `powershell-windows`   | Windows PowerShell patterns    |
| `linux-shell-scripting`| Production shell scripts       |

#### Rust

| Skill      | Description                                 |
| ---------- | ------------------------------------------- |
| `rust-pro` | Ownership, lifetimes, async, concurrency    |

#### Caching & Performance

| Skill                   | Description                          |
| ----------------------- | ------------------------------------ |
| `caching-patterns`      | Browser, CDN, Redis cache strategies |
| `performance-profiling` | Measurement, analysis, optimization  |

#### Agent Behavior

| Skill              | Description                       |
| ------------------ | --------------------------------- |
| `behavioral-modes` | Agent personas and modes          |
| `parallel-agents`  | Multi-agent orchestration         |
| `mcp-builder`      | Model Context Protocol servers    |

### Extra Skills (37) — `skills-extra/`

Niche, framework-specific, or specialized skills. Not loaded by default agents but available for manual use.

Includes: AI/LLM tools (langchain, langfuse, langgraph, rag-engineer, llm-evaluation), ML/Data (ml-engineer, mlops-engineer, data-scientist, airflow-dag-patterns), Monitoring (grafana-dashboards, prometheus-configuration), Agent tools (agent-memory-mcp, agent-tool-builder, agent-evaluation), and more.

Move any skill from `skills-extra/` to `skills/` and reference it in an agent's frontmatter to activate it.

---

## Workflows (15)

Slash command procedures. Invoke with `/command`.

| Command          | Description              |
| ---------------- | ------------------------ |
| `/brainstorm`    | Socratic discovery       |
| `/build-fix`     | Build error resolver     |
| `/create`        | Create new features      |
| `/debug`         | Debug issues             |
| `/deploy`        | Deploy application       |
| `/enhance`       | Improve existing code    |
| `/orchestrate`   | Multi-agent coordination |
| `/plan`          | Task breakdown           |
| `/preview`       | Preview changes          |
| `/refactor`      | Systematic refactoring   |
| `/review`        | Code review              |
| `/security`      | Security audit           |
| `/status`        | Check project status     |
| `/test`          | Run tests                |
| `/ui-ux-pro-max` | Design with 50 styles    |

---

## Skill Loading Protocol

```plaintext
User Request → Agent Selection → Load skills from frontmatter
                                        ↓
                                Read SKILL.md (index)
                                        ↓
                                Read specific sections
```

### Skill Structure

```plaintext
skill-name/
├── SKILL.md           # (Required) Metadata & instructions
├── scripts/           # (Optional) Python/Bash scripts
├── references/        # (Optional) Templates, docs
└── assets/            # (Optional) Images, logos
```

---

## Scripts (5)

Automation and validation scripts.

| Script               | Purpose                                      | When to Use               |
| -------------------- | -------------------------------------------- | ------------------------- |
| `checklist.py`       | Priority-based validation (core checks)      | Development, pre-commit   |
| `verify_all.py`      | Comprehensive verification (all checks)      | Pre-deployment, releases  |
| `auto_preview.py`    | Dev server management (start/stop/status)    | Local preview, testing    |
| `session_manager.py` | Project state analysis, tech stack detection | Session info, diagnostics |
| `detect_pm.py`       | Package manager auto-detection               | Build/test/deploy commands|

---

## Hooks (4)

Automated guardrails configured in `.claude/settings.json`. Run automatically without user intervention.

| Hook                      | Event        | Matcher      | Purpose                              |
| ------------------------- | ------------ | ------------ | ------------------------------------ |
| `dangerous_cmd_check.sh`  | PreToolUse   | Bash         | Block destructive commands           |
| `secret_scanner.sh`       | PreToolUse   | Write\|Edit  | Detect hardcoded secrets/credentials |
| `lint_check.sh`           | PostToolUse  | Edit\|Write  | Auto-lint after file changes         |
| `session_save.sh`         | Stop         | (all)        | Persist session context to memory    |

---

## Always-On Rules (5)

Located in `rules/common/`. Applied automatically to all code output.

| Rule              | Enforces                                        |
| ----------------- | ----------------------------------------------- |
| `git-workflow.md` | Conventional Commits, branch naming, PR format  |
| `coding-style.md` | Naming conventions, file organization, imports  |
| `testing.md`      | AAA pattern, coverage targets, test pyramid     |
| `security.md`     | Secret management, OWASP, input validation      |
| `performance.md`  | Core Web Vitals, bundle size, caching strategy  |

---

## Contexts (3)

Mode-specific behavior adjustments in `contexts/`. Load based on task type.

| Context        | When Active                     | Behavior Focus           |
| -------------- | ------------------------------- | ------------------------ |
| `dev.md`       | Writing new code, prototyping   | Fast iteration, debug    |
| `review.md`    | Code review, PR assessment      | Quality checklist, SOLID |
| `research.md`  | Tech comparison, investigation  | Evidence-based, tables   |

---

## Statistics

| Metric              | Value  |
| ------------------- | ------ |
| **Total Agents**    | 22     |
| **Core Skills**     | 56     |
| **Extra Skills**    | 37     |
| **Total Workflows** | 15     |
| **Total Scripts**   | 5      |
| **Total Hooks**     | 4      |
| **Total Rules**     | 5      |
| **Total Contexts**  | 3      |

---

## Quick Reference

| Need     | Agent                 | Skills                                |
| -------- | --------------------- | ------------------------------------- |
| Web App  | `frontend-specialist` | react-best-practices, frontend-design |
| API      | `backend-specialist`  | api-patterns, nodejs-best-practices   |
| Mobile   | `mobile-developer`    | mobile-design                         |
| Database | `database-architect`  | database-design                       |
| Security | `security-auditor`    | vulnerability-scanner                 |
| Testing  | `test-engineer`       | testing-patterns, webapp-testing      |
| Debug    | `debugger`            | systematic-debugging                  |
| Plan     | `project-planner`     | brainstorming, plan-writing           |
| AI/LLM   | `ai-engineer`         | architecture, api-patterns            |
| DevOps   | `devops-engineer`     | deployment-procedures                 |
| Pentest  | `penetration-tester`  | red-team-tactics                      |
