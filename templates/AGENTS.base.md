# Agent Instructions — {{PROJECT_NAME}}

These are local project defaults. Read README.md, architecture docs, .editorconfig, and more-specific AGENTS.md before editing. Current user instructions and project-specific rules take precedence. Explain conflicts rather than guessing.

## Engineering philosophy
- Maintainability and readability over cleverness; favor the smallest **complete** solution.
- Apply SOLID, DRY, KISS, and YAGNI pragmatically. KISS and YAGNI break ties when abstractions add complexity without value.
- Reuse existing implementations and patterns before inventing new frameworks or services.
- Improve cohesion and boundaries in code you touch when proportional; avoid unrelated refactors, speculative features, and unfinished placeholders.
- Keep classes and functions focused on cohesive responsibilities. Do not create a maze of one-method wrappers or needless interfaces.
- Preserve behavior, user data, public contracts, and existing architectural boundaries unless explicitly asked to change them.

## Architecture
- Keep business rules in the domain, use-case orchestration in application services, technical integrations in infrastructure, and UI/transport in presentation when the project warrants these boundaries.
- DDD is a toolbox, not a mandate. Small projects do not require a multilayer solution.
- Respect dependency direction; prefer constructor injection when it establishes a useful boundary or matches existing conventions.
- Do not force CQRS, mediator pipelines, vertical slices, microservices, or other architectural patterns into projects that do not need them.

## Quality and change workflow
1. Inspect existing implementation, callers, docs, and relevant tests before editing.
2. Plan proportionally for multi-layer, persistence, or contract changes.
3. Make focused, reviewable changes with relevant in-scope cleanup.
4. Add or update focused behavior tests; run applicable checks and report exactly what passed and what could not be run.
5. Update durable documentation for important architectural or operational discoveries.
6. Hand off with changed behavior, tests, remaining risks, and manual verification steps when useful.

## Documentation and planning
- Taiga is the source of truth for planned work, acceptance criteria, estimates, dependencies, and statuses when {{TAIGA_PROJECT}} is configured.
- Repository docs describe durable architecture, business invariants, APIs, configuration, and operations. Do not create feature-plan Markdown files by default.
- Do not silently delete old plans; migrate requirements and decisions first, repair links, and remove only when explicitly requested.
- Do not publish backlogs or change unrelated tickets without explicit authorization.
- When Taiga is configured, read docs/taiga-agent-workflow.md before ticket operations.
- If a credible high-priority defect, security issue, or substantial architectural problem is discovered in the area being changed, create a Taiga issue only when a matching project is configured and the guide's evidence, duplicate-check, metadata, and verification safeguards can be met. Otherwise report it without inventing a ticket.

## Change safety
- Do not edit generated build artifacts manually.
- Flag destructive migrations, data changes, and significant architectural departures.
- Do not commit, push, open PRs, or modify external systems unless explicitly authorized by the task or the narrow high-priority issue rule above.
- Do not claim tests, reviews, writes, deployments, or ticket transitions occurred without evidence.
