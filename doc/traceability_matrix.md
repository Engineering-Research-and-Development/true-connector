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