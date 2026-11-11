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

## High-Priority Findings: Create Taiga Issues


While working on an assigned change, **create a Taiga issue** if you discover a credible **high-priority bug, security vulnerability, or significant architectural problem** in the affected project. This is standing authorization to create that specific kind of issue, even when the user has not separately requested a ticket. It is not authorization to audit the repository, open routine cleanup tickets, or expand the implementation scope.

- **Apply a high threshold.** Examples include potential data loss or corruption, security exposure, incorrect important business results, broken core workflows, and responsibility/dependency-boundary violations with substantial correctness, reliability, or maintainability impact. A large class, style violation, or minor code smell alone does not qualify.
- **Gather concrete evidence.** Identify the affected feature and files, observed/reproducible behavior or specific architectural violation, practical impact, and why the issue is high priority. Clearly distinguish confirmed defects from suspected risks.
- **Find the correct Taiga project.** Use the configured project slug `{{TAIGA_PROJECT}}` and verified internal project ID `{{TAIGA_PROJECT_ID}}` from `docs/taiga-agent-workflow.md` for this repository. For cross-project problems, verify the owning project through the configured Taiga MCP connection. Never guess project IDs; if ownership cannot be determined, report the finding instead of filing it arbitrarily.
- **Check for duplicates before writing.** Use `list_issues` to search the owning project, including closed issues and all relevant result pages. If an equivalent issue exists, reference it rather than creating another.
- **Create an actionable issue.** Discover the project's issue types, priorities, severities, and statuses using the available `list_issue_*` metadata tools. Use `create_issue` with a clear subject and description covering evidence/reproduction, expected behavior or violated architectural boundary, impact, priority rationale, and a bounded remediation or investigation goal. Use only supported, verified project-specific values; never invent IDs or exaggerate severity.
- **Read back and report.** Verify the new issue using `get_issue`, then include its project and reference/link in the final handoff. If the MCP connection, tools, metadata, or permissions are unavailable, state what was found and why filing did not succeed. Never claim an issue was created without confirmation.
- **Keep working within scope.** A finding does not automatically authorize a separate fix or redesign. Continue the assigned work when safe; if the problem blocks it, explain the blocker. Focused refactoring of code already being changed remains encouraged under the standards above.

For authentication, ID/reference resolution, pagination, safe writes, and all other Taiga operations (planning, publication, status updates, and story workflows), read [the Taiga agent workflow guide](docs/taiga-agent-workflow.md). **Do not publish backlogs or modify unrelated tickets without separate authorization.**

## Change safety
- Do not edit generated build artifacts manually.
- Flag destructive migrations, data changes, and significant architectural departures.
- Do not commit, push, open PRs, or modify external systems unless explicitly authorized by the task or the narrow high-priority issue rule above.
- Do not claim tests, reviews, writes, deployments, or ticket transitions occurred without evidence.
