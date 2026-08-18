---
theme: nmt
background: https://cover.sli.dev
title: Selecting the Right Database for Your Project
class: text-left
transition: fade
mdc: true
duration: 90min
---

# Selecting the Right Database for Your Project
## A Structured Approach for Student Software Projects

### SaaS 1 – Cloud Application Development
### SaaS 2 – APIs & NoSQL

<!-- Presenter Notes:
Introduce this as a decision-making framework, not a database product list.
Emphasise that requirements drive technology, not popularity.
-->

---
layout: section
---

# Objectives

--- 
layout: two-cols
level: 2 
---


# Learning Objectives

::left::
## Categories, Requirements & Choice
- Describe major database categories and data models
- Identify functional and non-functional requirements
- Explain why database choice matters

::right::
## Selection Process & Documentation
- Apply a structured database selection process
- Compare databases using a decision matrix
- Justify database choices using evidence

<!-- Presenter Notes:
Read these explicitly.
Point out alignment with assessment verbs such as “describe”, “compare”, and “justify”.
-->


---
layout: section
---

# Warm-Up Activity


---
level: 2
layout: grid
---

# Warm-Up: Think About Your Data


::tl::
### Data Stored (1)
What data does your project store?

::bl::

### Frequency (2)
How often is data read or written?

<br>

::tr::
### Data Structure (3)
Is the data structured, semi-structured, or unstructured?

::br::
### Think...
Consider your mini-project & innovation project's goals...

<!-- Presenter Notes:
Pause here and allow students time to think.
This primes them to focus on data behaviour before tools.
-->

---
layout: section
---

# Why Database Selection Matters

---
level: 2
layout: grid
---

# Why the Choice Is Critical

::tl::
### Impact
Impacts performance, scalability, and reliability
::bl::
### Affects
Affects development complexity and maintenance
::tr::
### Influences
Influences cost across the system lifecycle
::br::
### Costs
Is expensive and risky to change later

<!-- Presenter Notes:
Emphasise that database migrations are disruptive, risky, and costly in real systems.
-->

---
layout: section
---

# Requirements First

---
level: 2
layout: grid
---

# Requirements First

::tl::


### Functional:

What the system must do with data.

::bl::

### Non-functional:

How well the system must operate

::tr::

#### FR Considerations

- Data structure and types
- Relationships between data
- Queries and access patterns
- Transactions and integrity

::br::

#### NFR Considerations

- Performance and latency
- Scalability
- Availability and fault tolerance
- Cost and operational effort

<!-- Presenter Notes:
- Functional requirements describe what the system must do with data.

- Non-functional requirements describe how well the system must operate.
-->

---
layout: section
---

# Data Models You Must Know

---
level: 2
---

# Common Database Models

- Relational
- Key–Value
- Document
- Column-Family
- Graph
- Time-Series
- Search-Oriented

<!-- Presenter Notes:
Stress that the data model matters more than the brand name.
-->

---
layout: two-cols
level: 2
---

# Relational Databases (SQL)

::left::

### Best for:

- Strong consistency (ACID)
- Structured data with relationships
- Transactions and reporting

<br>

### Examples (beyond the usual):

- Firebird
- H2
- MariaDB Xpand
- YugabyteDB


::right::

### Other Examples

**Non‑cloud:**
- PostgreSQL
- MySQL / MariaDB
- CockroachDB

**Managed / Cloud:**
- Amazon Aurora
- Azure SQL Database
- Google Cloud SQL
- AlloyDB


<!-- Presenter Notes:
Clarify that SQL does not automatically mean single-node or unscalable.

These all support strong consistency and relational models.
-->


---
level: 2
layout: two-cols
---

# Key–Value Stores

::left::

### Best for:

- Simple lookups
- Caching and session data
- Extremely low latency access


<br>

### Examples:

- Aerospike
- Riak KV
- DragonflyDB

::right::


### Key–Value / High Throughput

**Non‑cloud:**
- Redis
- Aerospike
- Riak KV
- DragonflyDB

**Managed / Cloud:**
- DynamoDB
- Azure Cache for Redis
- MemoryStore


<!-- Presenter Notes:
Explain that keys map directly to values with no joins or complex queries.

Optimised for speed, not relationships.
-->




---
level: 2
layout: two-cols
---

# Document-Oriented Databases

::left::

### Best for:

- Semi-structured JSON-like data
- Rapid schema evolution
- API-driven systems

<br>

### Examples:

- Couchbase
- RavenDB
- MarkLogic

::right::


### Other Document / API‑First Systems

**Non‑cloud:**
- MongoDB
- MarkLogic

**Managed / Cloud:**
- Azure Cosmos DB (Core API)
- MongoDB Atlas
- Firestore
- DocumentDB


<!-- Presenter Notes:
Highlight flexibility but note weaker relational joins.

Best for JSON-centric API workloads.
-->

---
level: 2
layout: two-cols
---

# Column-Family Stores

::left::

### Best for:

- Massive horizontal scale
- Write-heavy or analytical workloads

::right::

### Examples:

- ScyllaDB
- Apache HBase
- YugabyteDB (YCQL)

<!-- Presenter Notes:
Often used in telemetry and large-scale analytics systems.
-->

---
level: 2
layout: two-cols
---

# Graph Databases

::left::

### Best for:

- Relationship-heavy data
- Social networks and recommendations

::right::

### Examples:

- JanusGraph
- TigerGraph
- ArangoDB

<!-- Presenter Notes:
Explain why graph traversal outperforms relational joins for deep relationships.
-->


---
level: 2
layout: two-cols
---

# Time-Series Databases

::left::

### Best for:

- Metrics, logs, and sensor data
- High-ingest, time-ordered workloads

<br>

### Examples:

- VictoriaMetrics
- QuestDB
- OpenTSDB

::right::


### Other Analytics, Column & Time‑Series

**Non‑cloud:**
- ScyllaDB
- ClickHouse
- Apache Cassandra

**Managed / Cloud:**
- Bigtable
- Azure Data Explorer
- Amazon Timestream
- Snowflake


<!-- Presenter Notes:
Optimised for append-only timestamped data.

Not suitable for transactional systems.
-->

---
layout: section
---

# Structured Selection Process

---
level: 2
---

# Overview of the Process

- Define requirements
- Analyse data characteristics
- Identify workload patterns
- Evaluate consistency and scalability
- Assess operational constraints
- Document and justify

<!-- Presenter Notes:
This mirrors industry Architecture Decision Records (ADRs).

Frame this as a decision framework used by professionals, not a list of tools.

Stress that justification matters more than “getting the right answer.”
-->

---
level: 2
layout: two-cols
---

# Structured Decision Process

::left::

## Overview of the Process

1. Define requirements
2. Analyse data characteristics
3. Identify workload patterns
4. Evaluate consistency and scalability
5. Assess operational constraints
6. Document and justify the decision


::right::


## Scenario: 

<br>

#### Course Management System

We use this as an example for each stage

- Student enrolments
- Results recording
- Reporting with joins
- High data accuracy required

<!-- Presenter Notes:
Relatable scenario for students with clear relational needs.
-->


<!-- Presenter Notes:
Explain this as an Architecture Decision Record (ADR)-style workflow.
Each step narrows the field of valid options.
-->

---
layout: two-cols
---

# Selection Process

::left:: 

### Decision Matrix

<div style="line-height: 0.9rem; font-size: 0.8rem;">

| Criteria |  Weight<br>(1–5)  | Option<br>A  | Option<br>B  | Option<br>C |
|--------|:-----------------:|:------------:|:------------:|:---------:|
| Data model fit |                   |              |              | |
| Scalability |                   |              |              | |
| Performance |                   |              |              | |
| Consistency |                   |              |              | |
| Operational effort |                   |              |              | |
| Cost |                   |              |              | |
| **Total** |                   |              |              | |

</div>

::right::

### Quick Use Guide

Use this template with the stages of the decision process that follow.

- Weight indicates importance
- Score each option (0-10)
- Total will be sum of (Criteria Scores * weights)


<!-- Presenter Notes:
Weights reflect importance, not preference.
-->


---
layout: section
---

# Stage 1 – Define Requirements

---
level: 2
layout: two-cols
---

# Stage 1 – Define Requirements

<br>

## What This Step Does

This step clarifies **what the system must do**, independent of technology.

::left::

### Focus areas:
- Business goals
- Critical features
- Data correctness requirements


::right::

## How to Apply This Step

Ask:

- What would break the system if incorrect?
- Which data must always be accurate?
- Which features are core vs optional?


<!-- Presenter Notes:
This prevents “technology-first” decisions.

Encourage written bullet points, not vague statements.
-->

---
layout: two-cols
level: 2
---

# Stage 1 – Worked Example

<br>

## Example: Course Management System

::left::

### System needs to:
- Store enrolments and results
- Prevent incorrect grades
- Support reporting for compliance

::right::

### Key outcome:  
Strong data correctness is mandatory.

<!-- Presenter Notes:
Highlight that correctness immediately eliminates some NoSQL options.
-->

---
layout: section
---

# Stage 2 – Analyse Data Characteristics

---
level: 2
layout: two-cols
---

# Stage 2 – Analyse Data Characteristics

<br>

## What This Step Does

Identifies the **shape and structure of the data**.

::left::

## Consider:
- Is data structured?
- Are relationships important?
- Is schema stability expected?

::right::

## How to Apply This Step

 Evaluate:

- Tables vs documents vs relationships
- One-to-many and many-to-many links
- Schema changes over time

<!-- Presenter Notes:
This step aligns database model to data shape.

Students should sketch entities or documents here.
-->


---
level: 2
layout: two-cols
---

# Stage 2 – Analyse Data Characteristics

<br>

## Example: Course Management System

::left::

#### Data characteristics:
- Students ↔ Units ↔ Results
- Strong relationships
- Stable schema

::right::

#### Implication:  
Relational model is a strong candidate.

---
layout: section
---

# Stage 3 – Identify Workload Patterns

---
level: 2
layout: two-cols
---

# Stage 3 – Identify Workload Patterns

<br>

## What This Step Does

Determines how data is accessed.

::left::

### Key questions:
- Read-heavy or write-heavy?
- Transactional or analytical?
- Latency sensitive?


::right::

### How to Apply This Step

Estimate:
- Reads vs writes
- Peak vs average usage
- Query complexity

<!-- Presenter Notes:
Make explicit why key–value and wide-column are weak fits.

Workload can invalidate a good data-model fit.

Best done with rough numbers, not precision.
-->


---
level: 2
layout: two-cols
---

# Stage 3 – Identify Workload Patterns

<br>

## Example: Course Management System

::left::

### Workload:

- Frequent writes during enrolment
- Regular reads for reporting
- Moderate concurrency

::right::

### Implication:

Transactional (OLTP) system, not analytics-first.

<!-- Presenter Notes:
Eliminates data warehouse and column-family systems.
-->

---
layout: section
---

# Stage 4 – Consistency & Scalability

---
level: 2
layout: two-cols
---

# Stage 4 – Consistency & Scalability

<br>

## What This Step Does

Balances correctness, availability, and growth.

::left::

### Evaluate:
- Is eventual consistency acceptable?
- Required uptime
- Expected scale growth

::right::

## How to Apply This Step

Decide:
- Strong vs eventual consistency
- Vertical vs horizontal scaling
- Failure tolerance needed

<!-- Presenter Notes:
Frame CAP as trade-offs, not absolutes.
-->

---
layout: two-cols
level: 2
---

# Stage 4 – Consistency & Scalability

<br>

## Example: Course Management System

::left::

### Needs:

- Strong consistency for results
- Moderate scale growth
- High availability preferred but not at cost of correctness

::right::

### Implication:

Strongly consistent SQL system preferred.

<!-- Presenter Notes:
Explain why DynamoDB-style systems are risky here.
-->

---
layout: section
---

# Stage 5 – Operational Constraints

---
level: 2
layout: two-cols

---

# Stage 5 – Operational Constraints

<br>

## What This Step Does

Ensures the system can actually be run.

::left::

## Assess:

- Team skills
- Deployment complexity
- Cost and maintenance

::right::

## How to Apply This Step

Ask:
- Who maintains this?
- What happens at 2am?
- What is the backup strategy?


<!-- Presenter Notes:
This step prevents “theoretically perfect but unusable” systems.

This is where managed services often win.
-->

---
level: 2
layout: two-cols
---

# Stage 5 – Operational Constraints

<br>

## Example: Course Management System

::left::

### Constraints:

- Small development team
- Limited DBA skills
- Budget sensitivity

::right::

### Implication:

Managed relational database preferred.

<!-- Presenter Notes:
Operational simplicity justifies managed SQL.
-->

---
layout: section
---

# Stage 6 – Document & Justify

---
level: 2
layout: two-cols
---

# Stage 6 – Document & Justify

<br>

## What This Step Does

Creates a **defensible, assessable decision**.

::left::

### Includes:
- Assumptions
- Options considered
- Reasons for final choice

::right::

### Where?

- Part of project requirements documentation

<!-- Presenter Notes:
This maps directly to student assessment submission.
-->


---
layout: section
---

# Practice Exercise

---
level: 2
layout: two-cols
---

# Practice Exercise

Use the process just covered.<br>
Use the matrix to help make informed decisions.<br>
Note your answers, and reasoning down.


::left::

## Scenario

You are designing a **club membership system**:

- Member profiles
- Event registrations
- Payment records
- Reporting for audits


::right::

## Guided Questions

1. What are the strongest data relationships?
2. Is correctness or availability more important?
3. What workload dominates?
4. Which two DBMS options would you shortlist?


<!-- Presenter Notes:
This is deliberately similar but not identical to the worked example.

Require written answers for justification.
-->

---
layout: section
---

# Exit Questions 🎫

---
level: 2
layout: grid
---

# Ausgang nach links 🎫
<p style="width:100%; text-align: right; color: rgba(192,192,192,0.75); font-size: 0.6rem;">
DE: Exit on the left
</p>


Answer briefly:

::tl::

- Which selection step narrowed your options the most?

::tr::

- What mistake are you now less likely to make?

::bl::

- What database(s) would you choose for your mini-project?

::br::

- Which requirement(s) influenced your choice most?


<!-- Presenter Notes:
Use this to assess conceptual understanding, not recall.


End by reinforcing disciplined decision-making.
-->


---
 layout: end 
---
# Fin
#### Two Haiku for you this time...

<div class="grid grid-cols-2 gap-24 text-md">

<h2 style="font-size: 1.25rem; " class="bg-stone-900! text-stone-300! p-8 pt-6 border border-stone-700/50
rounded-lg ">
Right data, right load,  <br>
Trends fade, requirements stay,  <br>
Migrations hurt.
</h2>

<h2 style="font-size: 1.25rem"  class="bg-zinc-900! text-zinc-300! p-8 pt-6 border border-zinc-700/50
rounded-lg ">
Choose with intent,  <br>
Data shape before dashboards,  <br>
Migrations cost years.
</h2>

</div>

<!-- Presenter Notes:
End by reinforcing that good database choices reduce pain later.
-->
