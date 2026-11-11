# Taiga MCP: Agent Ticketing and Delivery Guide

**Project:** {{PROJECT_NAME}}  
**Taiga project slug:** `{{TAIGA_PROJECT}}`

Taiga owns work items, scope, estimates, dependencies, and workflow statuses. GitHub owns code, branches, PRs, test evidence, and durable technical documentation. AGENTS.md owns engineering standards. Follow the user's current request and local project rules.

## Before calling Taiga
- Use the configured MCP connection and inspect the tools' actual schemas. Never invent endpoints, credentials, IDs, permissions, or successful calls.
- Resolve the project slug with resolve_project or list_projects. Identify the user with get_current_user when needed and use list_project_members before assignment (assignee is user ID, not membership ID).
- Ticket references like #123 are project-local, **not** internal IDs. Resolve them with resolve_work_item and fetch the full item before changes.
- Fetch fresh item versions before versioned writes; discover project-specific statuses, priorities, severities, roles, and point options rather than guessing IDs.
- Follow pagination, including closed/archived work when checking duplicates or history. Some list endpoints require includePageInfo=true.

## Choose the right workflow
- Read-only status requests: discover and summarize; do not write.
- Plan an epic/story/task hierarchy: propose a reviewable hierarchy and role estimates; **planning alone never writes to Taiga**.
- Explicit publication: verify project, permissions, metadata, duplicates, and required tools; create and link in dependency order, then read back to verify.
- Flesh out an existing story: resolve the exact story and add only explicitly requested missing child tasks.
- Implement a story: read the full story, linked epic, and all relevant child tasks, including completed ones. Respect existing architecture and test expectations.
- Ordinary feature/bug work does not require creating routine tickets. The narrowly scoped high-priority finding rule in AGENTS.md is an exception.

## Hierarchy and estimates
- Epic: coherent outcome, boundaries, dependencies, non-goals, exit criteria.
- Story: independently reviewable outcome with acceptance criteria, definition of done, dependencies, verification, and expected PR destination.
- Task: concrete ordered checkpoint, prerequisites, expected result, and evidence.
- Make order explicit using an ordered story list or 01/02/03 task prefixes. Never infer order from response ordering or ticket numbers.
- Estimate stories, not individual tasks, using actual configured role and point options. Do not fabricate estimates.

## Safe writes
- Search all relevant open and closed/archived items for duplicates before creation.
- Preserve existing descriptions, relationships, attachments, assignments, and history unless explicitly authorized to change them.
- Use freshly read versions for updates and comments. On conflicts, re-read; on ambiguous timeouts, inspect authoritative state before retrying.
- Record meaningful blockers and evidence without noisy comments. Never expose secrets or signed attachment URLs.
- Read back and report confirmed status, references, links, estimates, and any incomplete operations. Do not claim a PR is merged or deployed merely because it exists.

## Source references
- [TaigaMCP README](https://github.com/blakeg83/taiga-mcp/blob/master/README.md)
- [Taiga tool reference](https://github.com/blakeg83/taiga-mcp/blob/master/docs/taiga_tools_reference.md)
- [Work-item examples](https://github.com/blakeg83/taiga-mcp/blob/master/docs/work_item_examples.md)
- [Backlog publisher skill](https://github.com/blakeg83/taiga-mcp/blob/master/.agents/skills/taiga-backlog-publisher/SKILL.md)

Use an optional specialized skill only when explicitly invoked and supported by the host; its own instructions govern its execution.
