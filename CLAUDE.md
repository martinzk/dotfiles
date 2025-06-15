# CLAUDE CODE INSTRUCTIONS

## IMMEDIATE RESPONSE REQUIRED FOR IMPROVEMENT REQUESTS

When user asks to "analyze", "fix", "improve", "refactor", "optimize" or "enhance" code, you MUST respond with:

**"TEST COVERAGE CHECK REQUIRED"**

Then immediately run this checklist:

## The Only Checklist That Matters

Before ANY analysis that leads to changes:
- [ ] **STOP: Am I planning to make changes based on this analysis?** (If YES, proceed to test check)
- [ ] **Do tests exist for the code I am planning to change?** (If no, write them first)
- [ ] **Did I run existing tests?** (Verify current behavior)
- [ ] **Will tests catch regressions?** (Ensure coverage of changes)
- [ ] Is this the smallest possible change?
- [ ] Will a junior developer understand this?
- [ ] Does the test prove the fix?
- [ ] Can I delete something instead?

## Prime Directives

**Every line of code must justify its existence.**

### 1. Test the Change, Not the World
- NO CODE CHANGES WITHOUT TESTS
- **ALWAYS**: Is there test coverage for the change I am planning?

### 2. Readability is Non-Negotiable
- Name variables to eliminate comments
- One concept per line
- Early returns over nested conditions
- Explicit over implicit
- Always add "ABOUTME: " header comments to new files

### 3. Surgical Precision
- Touch only what must change
- Delete before adding
- Refactor before extending broken design
- Stop when you hit resistance - propose better approach

### 4. Commit Atomically
- Feature works? Commit.
- Test passes? Commit.
- Each commit must leave main branch deployable.

### 5. Design Flaws = Full Stop
When current change reveals poor design:
1. Stop immediately
2. Document the issue
3. Propose minimal refactor
4. Only proceed after refactor


## Non-Negotiable Rules

1. **Functions: 10 lines or split**
2. **Names: No abbreviations** (`calculate_distance` not `calc_dist`)
3. **Comments: Only for "why", never "what"**
4. **NO CODE CHANGES WITHOUT TESTS - Test first, change second, verify third**
5. **Commits: Present tense** ("Add user validation", not "Added")

## Red Flags - Stop Immediately

- **"No tests exist for this code"** - STOP. Write tests first.
- **"Tests are failing after my change"** - STOP. Fix or revert.
- **"I'll add tests later"** - STOP. Tests come first.
- **User requests to "analyze for readability"** - STOP. Check tests first.
- **User requests to "fix issues"** - STOP. Check tests first.  
- **User requests to "improve code"** - STOP. Check tests first.
- **I identify problems I want to solve** - STOP. Check tests first.
- "Just one more if statement"
- "I'll refactor it later"
- "The test is too hard to write"
- Copy-pasting code
- Fighting the framework

### KEY INSIGHT: Analysis + Intent to Improve = Code Change Planning
The moment you start identifying "what should be fixed," you are planning changes.
**CHECK TESTS IMMEDIATELY - DO NOT PROCEED WITH ANALYSIS.**

### Common Refactoring Anti-Patterns to AVOID
- **Extract for Size**: Breaking up cohesive code just because it's long
- **Horizontal Slicing**: Splitting by technical layers instead of business concerns
- **Premature Abstraction**: Creating abstractions without clear domain boundaries

## Example: The Claude Code Way

```python
# WRONG - Building on broken design
def process_user(user, send_email=True, validate=True, transform=True):
    # 50 lines of nested ifs

# RIGHT - Stop and refactor first
def validate_user(user): ...
def transform_user(user): ...
def notify_user(user): ...
```

**Remember: If explaining takes more words than coding, your code is wrong.**

## Continuous Improvement Loop
After each refactoring proposal, ask:
1. "Does this address the root architectural issue?"
2. "Will developers understand this better or worse?"
3. "Am I solving the real problem or just moving code around?"
4. "What missing domain abstractions am I actually addressing?"

Remember: Good architecture makes code easier to understand, not just smaller to read. When in doubt, optimize for clarity over cleverness.

## Mandatory Testing Commands

- **ALWAYS run existing tests before changing code**
- **ALWAYS write tests for new Use Cases/domain logic**
- **NEVER commit without test verification**
- **NEVER refactor without test coverage**
- If no tests exist for code you're changing: **STOP and write tests first**

## ENFORCEMENT: Standard Response Template

When asked to analyze/improve/fix code, you MUST use this exact response pattern:

```
TEST COVERAGE CHECK REQUIRED

Before I analyze [COMPONENT] for improvements:
- [ ] Do tests exist for code I plan to change? [Checking...]
- [ ] Result: [YES/NO - specific test files found]
- [ ] If NO: I must write tests first before any analysis
- [ ] If YES: I will run tests first to verify current behavior

[Only proceed with analysis AFTER completing the above checklist]
```

This prevents the mental separation of "analysis" vs "changes" that bypasses test requirements.
