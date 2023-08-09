# TRUE Connector traceability matrix

This is the TRUE Connector traceability matrix for known major issues. The rating ranges from 1 (high priority) to 3 (low priority). For further details on issues please check the Github issues section of the [Data App](https://github.com/Engineering-Research-and-Development/true-connector-basic_data_app/issues) and [Execution core container](https://github.com/Engineering-Research-and-Development/true-connector-execution_core_container/issues).

| Priority | Issue         | Status       | Note |
|:---:|:------------|:------------|:------------|
| 1 | Base64 encoded payload support | Done | |
| 1 | Docker image GHA fails | Done | |
| 1 | add Clearing house authentication header | Done | |
| 2 | Error is printed in log when requesting self description | | |
| 3 | Stack trace is returned when configuration and request are not matched | | |
| 3 | Change payload from String to byte array | | |


## Vulnerability Remediation Process

Vulnerability Remediation Process is done as following:
1. Dependabot code analysis for security vulnerabilities is done automatically
2. Analyzing vulnerabilities
3. Proposing code change in accordance with version update of dependency at risk
4. Fixing/updating and releasing new TRUE Connector version

Based on the severity (Common Vulnerability Scoring System is used) of the issues (Critical, High, Moderate, Low), addressing the issue should be taken into consideration.

| Severity | Time for fixing |
|:---:|:--------- |
| Critical | < 1 week |
| High | < 3 weeks |
| Moderate | < 1 month |
| Low | < 2 months |

For issues that are currently reported, you can always check Security tab for specific subcomponent and in Dependabot section  find all opened issues.


## Security issues implemented

Fixes for security issues should be covered with tests. Once issue is fixed, new GitHub Action should be created and added to the existing set of tests (when applicable). 

| Description | Fixed version TC | Component |
|:------------|:---------:|:---------:|
| com.auth0:jwks-rsa from 0.21.1 to 0.22.1 | 1.0.1 | ECC |
| net.logstash.logback:logstash-logback-encoder from 7.0.1 to 7.3 | 1.0.1 | ECC |
| com.auth0:java-jwt from 3.19.1 to 3.19.3 | 1.0.1 | ECC |
| org.bitbucket.b_c:jose4j:0.7.8 to 0.9.3 | 1.0.1 | ECC |
| TLS 1.3 as mandatory way for communication | 1.0.1 | ECC, DA, UC |

