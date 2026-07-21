If delivery finishes at **Week 17**, I would structure the course so that all teaching is complete by then, leaving assessment and catch-up outside the formal teaching sequence. This also better aligns with the competency requirements of **ICTDBS507** and **ICTPRG556**.

| Week   | Topic                                                                      | Unit Focus |
| ------ | -------------------------------------------------------------------------- | ---------- |
| **1**  | Course Introduction, Development Environment, Git/GitHub Workflow          | PRG556     |
| **2**  | Modern PHP Refresher and Object-Oriented Programming                       | PRG556     |
| **3**  | HTTP Fundamentals, Request/Response Cycle and Web Architecture             | PRG556     |
| **4**  | MVC Design Pattern and Laravel Architecture                                | PRG556     |
| **5**  | Routing, Controllers and Blade Views                                       | PRG556     |
| **6**  | Forms, Validation and Request Handling                                     | PRG556     |
| **7**  | Relational Database Fundamentals, SQL and Database Design                  | DBS507     |
| **8**  | Database Configuration, Connections, Migrations and Seeders                | DBS507     |
| **9**  | Eloquent Models, CRUD Operations and Query Builder                         | Both       |
| **10** | Model Relationships, Searching, Filtering and Pagination                   | Both       |
| **11** | Authentication, Sessions, Middleware and Authorisation                     | Both       |
| **12** | RESTful Applications – GET, POST, PUT, PATCH and DELETE                    | PRG556     |
| **13** | File Uploads, Validation, Storage and Data Integrity                       | DBS507     |
| **14** | Security Fundamentals – SQL Injection, XSS, CSRF and Secure Authentication | Both       |
| **15** | Testing, Debugging, Logging and Browser Developer Tools                    | PRG556     |
| **16** | Deployment, Environment Configuration and Production Readiness             | Both       |
| **17** | Capstone Integration Project, Review and Competency Consolidation          | Both       |

### Notes for the LAP

The following topics should remain as **stand-alone lessons** rather than being merged:

* HTTP fundamentals before introducing Laravel.
* MVC architecture before writing controllers.
* SQL and relational database concepts before Eloquent.
* Database migrations before CRUD.
* Authentication before middleware and authorisation.
* RESTful HTTP methods before building APIs.
* Security as a dedicated lesson rather than being sprinkled throughout.
* Testing and debugging as a dedicated lesson.
* Deployment as a separate lesson from development.

### Topics to Verify Against the Repository

When I review the repository in detail, I'll specifically check whether these are adequately covered or need additional material:

* Database planning and integration documentation.
* SQL normalisation and schema design.
* HTTP redirects and model binding.
* PUT/PATCH request handling.
* Browser compatibility testing (required by ICTDBS507).
* NoSQL concepts (knowledge evidence only).
* Query optimisation and indexing.
* Production deployment and environment management.

I think this 17-week sequence is a stronger structure than a typical Laravel tutorial because it introduces the underlying concepts **before** the framework abstractions, making it much better suited to a TAFE Diploma course and the competency requirements of both units.
