---
theme: nmt
background: https://cover.sli.dev
title: Session 05 - Databases - Which One?
class: text-left
drawings:
  persist: false
transition: fade
mdc: true
duration: 35min
---

# Session 05: Databases - Which One?

## SaaS 1 – Cloud Application Development (Front-End Dev)

## SaaS 2 – APIs & NoSQL (Back-End Dev)

<div @click="$slidev.nav.next" class="mt-12 -mx-4 p-4" hover:bg="white op-10">
<p>Press <kbd>Space</kbd> or <kbd>RIGHT</kbd> for next slide/step <fa7-solid-arrow-right /></p>
</div>

<div class="abs-br m-6 text-xl">
  <a href="https://github.com/adygcode/SaaS-FED-Notes" target="_blank" class="slidev-icon-btn">
    <fa7-brands-github class="text-zinc-300 text-3xl -mr-2"/>
  </a>
</div>


<!-- Presenter Notes:
- The last comment block of each slide will be treated as slide notes. 
- It will be visible and editable in Presenter Mode along with the slide. 
- [Read more in the docs](https://sli.dev/guide/syntax.html#notes)
-->


---
layout: default
level: 2
---

# Navigating Slides

Hover over the bottom-left corner to see the navigation's controls panel.

## Keyboard Shortcuts

|                                                     |                             |
|-----------------------------------------------------|-----------------------------|
| <kbd>right</kbd> / <kbd>space</kbd>                 | next animation or slide     |
| <kbd>left</kbd>  / <kbd>shift</kbd><kbd>space</kbd> | previous animation or slide |
| <kbd>up</kbd>                                       | previous slide              |
| <kbd>down</kbd>                                     | next slide                  |

---
layout: section
---

# Objectives

---
layout: two-cols
level: 2
class: text-left
---

# Objectives


By the end of this session, students will be able to:

::left::
- Describe major database categories and data models
- Compare functional and non-functional requirements
- Map project needs to appropriate database technologies

::right::
- Justify database choices using a structured method
- Explain trade-offs between consistency, scalability, and cost
- Reference real-world database systems in design decisions



<!-- Presenter Notes:

-->

---
level: 2
---

# Contents

<Toc minDepth="1" maxDepth="1" columns="2" />



---
layout: section
---

# Warm-up time!

---
level: 2
---

# Warm-up time!


**Prompt:**  
Think about a past or current project you are working on.

- What data does it store?
- How often is the data read or written?
- Is the data structured, semi-structured, or unstructured?

> **Presenter Notes:**  


<!-- Presenter Notes:

Short pair discussion (3–5 minutes). Emphasise that technology choices should come *after* understanding the problem and data characteristics.

-->


---
layout: section

---
# Why Choosing the Right Database Matters

---
level: 2
---

# Why Choosing the Right Database Matters

## Why Database Choice Is Critical

- Impacts performance, scalability, and reliability
- Affects development speed and maintenance effort
- Determines operational cost and hosting options
- Poor choices are expensive and risky to change later


<!-- Peresenter Notes:

Poor choices are expensive to fix later

Presenter Notes:
Discuss how database migrations are complex and risky. Emphasise that early design decisions strongly influence long-term system success (GeeksforGeeks, 2024; SolarWinds, 2023).

-->



layout: section
Key Decision Criteria


level: 2
Core Selection Factors

Data model (relational, document, graph, etc.)
Workload type (read-heavy vs write-heavy)
Scalability needs (vertical vs horizontal)
Consistency and availability
Operational complexity
Cost and licensing

Presenter Notes:
Introduce these as a checklist repeated throughout the session. Emphasise requirements-first thinking (Paessler, 2024; EnterpriseDB, 2024).




layout: section
Data Models You Must Know


level: 2
Common Data Models

Relational
Key–Value
Document
Column-Family
Graph
Time-Series
Search-Oriented

Presenter Notes:
Explain that data models describe how data is organised, not just which product is used. See Rohan Dutt (2023) for a practical overview with production examples.




layout: section
Relational Databases (SQL)


level: 2
Relational Databases
Best for:

Strong consistency requirements
Structured data with clear relationships
Transactions (ACID)
Less well-known examples:

Firebird
H2 Database
MariaDB Xpand
YugabyteDB (distributed SQL)

Presenter Notes:
Relational databases use tables, rows, and schemas. Emphasise integrity and joins. Cite that not all SQL systems are monolithic (GeeksforGeeks, 2024; EnterpriseDB, 2024).




layout: section
Key–Value Databases


level: 2
Key–Value Stores
Best for:

Simple lookups
Caching and session management
Extremely fast access
Examples (less mainstream):

Aerospike
Riak KV
DragonflyDB

Presenter Notes:
Keys map directly to values. No joins or complex queries. Often used as supporting infrastructure in larger systems (Dev.to – Tinybird, 2023).




layout: section
Document Databases


level: 2
Document-Oriented Databases
Best for:

Semi-structured JSON-like data
Rapid schema evolution
APIs and microservices
Examples beyond the usual:

Couchbase
RavenDB
MarkLogic

Presenter Notes:
Documents map cleanly to API payloads. Note trade-offs in joins and transactions (Medium – Wix Engineering, 2022; WebDevStory, 2023).




layout: section
Column-Family Databases


level: 2
Column-Family Stores
Best for:

Massive scale
Analytical or write-heavy workloads
Examples:

ScyllaDB
Apache HBase
YugabyteDB (YCQL mode)

Presenter Notes:
Optimised for horizontal scalability and throughput. Often used in telemetry and analytics systems (DZone, 2023; SolarWinds, 2023).




layout: section
Graph Databases


level: 2
Graph Databases
Best for:

Relationship-heavy data
Social networks, recommendations, fraud detection
Examples:

JanusGraph
ArangoDB (multi-model)
TigerGraph

Presenter Notes:
Graphs excel where relationships are first-class citizens. Traversals outperform relational joins for deep connections (Rohan Dutt, 2023).




layout: section
Time-Series Databases


level: 2
Time-Series Databases
Best for:

Metrics, logs, sensor data
High-ingest rates with timestamps
Examples:

VictoriaMetrics
QuestDB
OpenTSDB

Presenter Notes:
Designed for append-only, time-indexed data. Common in DevOps and IoT systems (SolarWinds, 2023).




layout: section
How to Choose: A Structured Method


level: 2
Step-by-Step Selection Process

Define project requirements
Identify dominant data model
Estimate scale and workload
Consider consistency vs availability
Evaluate operational constraints
Justify and document your choice

Presenter Notes:
Reinforce documentation and justification as assessment-friendly outcomes (GeeksforGeeks, 2024; Paessler, 2024).




layout: section
Exercises, Questions and Practice


level: 2
Exercise: Database Matching
Given a project scenario:

Identify the primary data model
Choose a suitable database type
Name one real-world system
Justify your decision


layout: section
Session Checklist!


level: 2
Session Checklist
By the end of this session, students should be able to:

Explain why database selection matters
Describe key database models
Match databases to use cases
Justify choices with references


layout: section
Exit Tickets 🎫


level: 2
Exit Tickets – Reflection
Answer in one or two sentences:

What database would you choose for your current project, and why?


layout: section
Additional Learning & Further Study


level: 2 layout: two-cols
Additional Learning & Further Study
::left::
Videos

Database Types Explained – freeCodeCamp (YouTube)
SQL vs NoSQL – IBM Technology (YouTube)
::right::
Articles

Database selection guides
Data modeling fundamentals


layout: section
References & Acknowledgements


level: 2
References (APA 7)
GeeksforGeeks. (2024). How to choose the database. https://www.geeksforgeeks.org/dbms/how-to-choose-the-database/
Paessler. (2024). Key considerations when choosing a DBMS. https://blog.paessler.com/key-considerations-when-choosing-a-dbms
EnterpriseDB. (2024). How to choose which database to use. https://www.enterprisedb.com/blog/how-choose-which-database-use
SolarWinds. (2023). Databases 101: Factors to consider. https://www.solarwinds.com/blog/databases-101-factors-to-consider-when-choosing-a-database
SolarWinds. (2023). Databases 101: Choosing the right database. https://www.solarwinds.com/blog/databases-101-choosing-the-right-database
Dev.to (Tinybird). (2023). How to choose the right type of database. https://dev.to/tinybirdco/how-to-choose-the-right-type-of-database-2n1g
DZone. (2023). Choosing the right database for your application. https://dzone.com/articles/choosing-the-right-database-for-your-application
WebDevStory. (2023). Choosing the right database. https://www.webdevstory.com/choosing-the-right-database/
Medium – Wix Engineering. (2022). How to choose the right database for your service. https://medium.com/wix-engineering/how-to-choose-the-right-database-for-your-service-97b1670c5632
Dutt, R. (2023). 10 data models every data engineer must know. https://medium.com/@Rohan_Dutt/10-data-models-every-data-engineer-must-know-before-they-break-production-11a020e87e31


level: 2
References & Acknowledgements (2)
Slide template: Adrian Gould 
AI Use: Some content generated with assistance from Microsoft Copilot


layout: end
Fin!
Tables align, graphs connect,
Choose your data home with care,
Migrations are pain.





---
layout: section
# Cloud-Managed Database Equivalents

---
level: 2
## Why Cloud-Managed Databases?

- Reduce operational overhead (patching, backups, scaling)
- Provide built-in high availability and monitoring
- Allow teams to focus on application logic, not infrastructure

---
level: 2
## Relational (SQL) – Managed Services

| Cloud | Service | Notes |
|------|---------|-------|
| AWS | Amazon Aurora | MySQL/PostgreSQL compatible, auto-scaling storage |
| Azure | Azure SQL Database | Fully managed SQL Server-compatible service |
| GCP | Cloud SQL | Managed MySQL, PostgreSQL, SQL Server |

---
level: 2
## NoSQL – Document & Key–Value

| Cloud | Service | Model |
|------|---------|-------|
| AWS | DynamoDB | Key–Value / Document |
| Azure | Cosmos DB | Multi-model (Core, MongoDB, Gremlin) |
| GCP | Firestore | Document-oriented |

---
level: 2
## Analytics, Graph, and Time-Series

| Cloud | Service | Use Case |
|------|---------|----------|
| AWS | Timestream | Time-series metrics and IoT |
| Azure | Azure Data Explorer | Logs and telemetry |
| GCP | Bigtable | Wide-column / time-series |

---
layout: section
# Decision Matrix: Weighted Scoring

---
level: 2
## Decision Matrix (Blank Template)

| Criteria | Weight (1–5) | DB Option A | DB Option B | DB Option C |
|---------|--------------|------------|------------|------------|
| Data model fit | | | | |
| Scalability | | | | |
| Performance | | | | |
| Consistency | | | | |
| Operational effort | | | | |
| Cost | | | | |
| **Total Score** | | | | |

---
level: 2
## Decision Matrix (Worked Example)

| Criteria | Weight | PostgreSQL | Document DB | Key–Value DB |
|---------|--------|------------|-------------|--------------|
| Data model fit | 5 | 5 | 3 | 2 |
| Scalability | 4 | 3 | 4 | 5 |
| Performance | 3 | 4 | 4 | 5 |
| Consistency | 5 | 5 | 3 | 2 |
| Operational effort | 2 | 3 | 4 | 5 |
| Cost | 1 | 3 | 3 | 4 |
| **Total (weighted)** | | **86** | 78 | 79 |

---
layout: section
# Guided Practice: Worked Student Example

---
level: 2
## Scenario

You are building a **TAFE course management system**:

- Students enrol in courses and units
- Lecturers record results
- Reports require joins across students, units, and results
- Data accuracy is critical

---
level: 2
## Guided Questions

- What type of data is being stored?
- Are relationships important?
- Is strong consistency required?
- What growth is expected over time?

---
level: 2
## Model Answer

**Recommended database:** Relational SQL database (e.g., PostgreSQL or Azure SQL)

**Justification:**
- Highly structured data with clear relationships
- Strong transactional consistency required for results
- Joins and reporting are central to the system
- Managed SQL service reduces operational overhead





---
layout: section
level: 1
---

# Section Heading


<!-- Presenter Notes:

- ...

-->


---
level: 2
---

# Section Heading

## Section Sub-Heading


<!-- Presenter Notes:

...

-->


---
layout: section
---

# Exercises, Questions and Practice

<!-- Presenter Notes:

- ...

-->

---
level: 2
---

# Exercises, Questions and Practice

## Content type: and Sub-heading


<!-- Presenter Notes:

- ...

-->


---
layout: section
---

# Session Checklist!

<!-- 
Presenter notes:
Wrap-up: provide a quick checklist of what was covered and then exit tickets as
last slide for reflection/self-assessment.
-->

---
level: 2
---

## Session Checklist

By the end of this session, students should be able to:

- [ ] 

<!-- Presenter Notes:

- ...

-->

---
layout: section
---


# Exit Tickets 🎫

<!-- Presenter Notes:

- ...

-->

---
level: 2
---
# Exit Tickets 🎫

## Exit Tickets - Reflection & Self-Assessment

TODO: Exit Tickets


<!-- Presenter notes:

...

-->


---
layout: section
---

# Additional Learning <br>& Further Study

<Announcement type="info"   style="line-height: 1rem; margin-top: 2rem; padding: 1.5rem;          margin-left: 24ch;"   title="Further Study">
<p style="line-height: 1.5rem;">The following resources provide more 
in‑depth information on databases, SQL, and related concepts.</p> 
<p style="line-height: 1.5rem;">They are provided for out of class study 
purposes.</p>
</Announcement>

---
level: 2
layout: two-cols
---

<h1 style="margin-bottom:0">Additional Learning & Further Study</h1>

::left::

### Content Type (eg. video) or Content area (eg. SQL)

- TODO: Free online content to assist learning 

<!-- Presenter Notes:

- ...

-->

---
layout: section
---

# Acknowledgements & References

<!-- Presenter notes:

Section: References. Provide reputable sources for further study in APA 7 style.

-->

---
level: 2
---

# References & Acknowledgements

- TODO: References


<!-- Presenter Notes:

- ...

-->

---
level: 2
---

# References & Acknowledgements (2)

<br>

<Announcement type="info" style="width: 100%; padding: 1rem;" title="Disclosures">
<p><b>Slide template:</b> Adrian Gould</p>
<p><b>AI Use:</b> Some content was generated with the assistance of Microsoft 
CoPilot</p>
</Announcement>


<!-- Presenter Notes:

- ...

-->

---
level: 2
layout: end
---

<h1 style="text-align: left">
Fin!
<br>
<br>
TODO: A suitable Haiku with some humour, summarising the content
</h1>


<!-- Presenter Notes:

- ...

-->
