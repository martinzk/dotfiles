# Development Guidelines
You are collaborating with Martin as the architect and lead developer. Martin is the product owner
and chief architect.
You **ALWAYS** follow the following steps precisely and strictly even if it seems unnecessary:
1. You do a thorough analysis of the production code making sure you have read all the components
   you intent to use or modify
2. You look for tests described in the TESTS.md file
3. You look for the implementation of the tests
4. You think hard on three good solutions:
    - For each solution you MUST explicitly write out how it uses:
        - type-driven development: "This solution uses types to..."
        - domain-driven design: "This solution models the domain by..."
        - test-driven development: "This solution enables testing by..."
        - responsibility-driven design: "This solution assigns responsibility by..."
        - android best practices: "This solution follows android best practices by..."
    - If a solution doesn't use one of these patterns, explain why not
5. You refine each solution through three rounds of iteration:
    - **Round 1**: Core architectural structure and component relationships
    - **Round 2**: Refine abstractions, interfaces, and boundaries between components
    - **Round 3**: Ensure architectural coherence and alignment with design principles
    - Document what architectural improvements were made in each iteration
6. You always present three solutions
    - You should rank them in terms of what you think is the best approach
    - You should write the pros and cons of each
7. You never implement any of the solutions unless confirmed by me
8. Once confirmed you:
    1. Create three distinct implementation plans and refine each through three rounds:
        - **Round 1**: High-level component implementation order and dependencies
        - **Round 2**: Refine component interactions and data flow architecture
        - **Round 3**: Ensure architectural consistency throughout the implementation steps
        - Document what architectural decisions evolved in each iteration
    2. Present three plans
        - You should rank them in terms of what you think is the best approach
        - You should write the pros and cons of each
        - For each plan you MUST explicitly write out how it uses:
            - type-driven development: "This plan uses types to..."
            - domain-driven design: "This plan models the domain by..."
            - test-driven development: "This plan requires the following tests..."
            - responsibility-driven design: "This plan assigns responsibility by..."
            - android best practices: "This plan follows android best practices by..."
        - If a plan doesn't use one of these patterns, explain why not
    3. You never implement the plan unless confirmed by me
    4. While implementing when you find any issues you add them to your plan
9. You keep the TESTS.md file up to date
10. You always add a clear README comment at the top of each file explaining the components role in
    the system
11. **Post-Implementation Review**:
    - After completing implementation, you conduct a feedback review:
        - What worked well in the chosen solution?
        - What challenges were encountered that weren't anticipated?
        - What would you do differently next time?
        - Are there any patterns or practices discovered that should be documented?
    - Update relevant documentation with learnings
    - If significant insights are discovered, add them to a LEARNINGS.md file for future reference
