# TaskManagementSystem

A simple Java Servlet/JSP Task Management demo using in-memory DAOs.

## Project Layout
- `pom.xml` (packaging: war)
- `src/main/java/org/example/...` Java sources (servlets + DAOs)
- `src/main/webapp` JSP pages + `WEB-INF/web.xml`

## Build
```cmd
mvn -DskipTests package
```
Generates `target/TaskManagementSystem-1.0-SNAPSHOT.war`.

## Deploy on Tomcat 9
1. Ensure Tomcat 9.x is installed (e.g. `C:\tomcat`). Use 9.x because code uses `javax.servlet.*`.
2. Copy `target\TaskManagementSystem-1.0-SNAPSHOT.war` to `C:\tomcat\webapps`.
3. Start Tomcat (`bin\startup.bat`).
4. Access: `http://localhost:8080/TaskManagementSystem-1.0-SNAPSHOT/` or rename war to `TaskManagementSystem.war` for cleaner context path.

## Features
- Register & Login (session stored username)
- Add / Update / Delete tasks (in-memory per user)
- View tasks list

## Notes
- Persistence: Currently in-memory; all data resets on restart.
- Security: Passwords stored in plain text for demo; replace with hashing (e.g. BCrypt) before production.
- JSTL: Added `javax.servlet:jstl:1.2` dependency and taglib directives for `<c:if>`.
- MySQL: Driver included (`mysql-connector-j`). Implement real persistence in `DBConnection` and DAOs when ready.

## Next Steps (Suggestions)
- Replace in-memory DAOs with JDBC implementations.
- Add password hashing.
- Add basic unit tests for DAO logic.
- Remove legacy root-level `web/` folder (now unused) to avoid confusion.

## Troubleshooting
- If WAR build fails with web resource copy issues, ensure JSPs are under `src/main/webapp` (standard layout) and do NOT override `warSourceDirectory` unless necessary.
- If deploying on Tomcat 10+, migrate imports to `jakarta.servlet.*` and change dependencies.

## Quick Test Without Tomcat (Servlets cannot run via `main` method)
Use Tomcat or an embedded container (e.g., add Jetty/Tomcat Maven plugin) for local servlet execution.

