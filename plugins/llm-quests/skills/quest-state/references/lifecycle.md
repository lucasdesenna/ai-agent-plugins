# Quest Lifecycle

| Phase         | Value           | Purpose                                               | Exit Criteria                                                    |
| ------------- | --------------- | ----------------------------------------------------- | ---------------------------------------------------------------- |
| Scouting      | `scouting`      | Capture trigger, define problem, assess complexity    | Problem Definition written, unknowns listed, phase plan approved |
| Discovery     | `discovery`     | Resolve unknowns with source-backed investigation     | Unknowns resolved or explicitly deferred                         |
| Planning      | `planning`      | Turn findings into an execution plan                  | Execution plan approved by user                                  |
| Formalization | `formalization` | Draft and create Jira cards for team visibility       | Jira cards created and linked, if this phase applies             |
| Execution     | `execution`     | Carry out the plan with bounded tasks and subagents   | Execution plan tasks complete                                    |
| Documentation | `documentation` | Produce a quest summary from artifacts                | `summary.md` written and approved                                |
| Improvement   | `improvement`   | Capture friction and propose methodology improvements | Concrete improvement plan recorded                               |
| Complete      | `complete`      | Terminal state                                        | No further lifecycle work                                        |

## Transition Rules

- Move forward only.
- The main session applies transitions after reviewing phase output.
- Skipped phases must be crossed out or noted in the Phase Plan with a reason.
- Legacy `insights` means `improvement`; normalize new or edited quests to `improvement`.
