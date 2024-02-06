# TRUE Connector traceability matrix

This is the TRUE Connector traceability matrix for known major issues. The rating ranges from 1 (high priority) to 3 (low priority). For further details on issues please check the Github issues section of the [Data App](https://github.com/Engineering-Research-and-Development/true-connector-basic_data_app/issues) and [Execution core container](https://github.com/Engineering-Research-and-Development/true-connector-execution_core_container/issues).


| Classification | Severity | Report Date | Issue | Description | Detailing Location | Affected Component | Impact | Status |
|:--------------:|:--------:|:-----------:|:-----:|:-----------:|:------------------:|:------------------:|:------:|:------:|
| Functional     | High     | 2023-01-10  | Base64 encoded payload support | Support for Base64 encoded payloads | Internal ticket| Data App | Data handling efficiency | DONE |
| Functional     | High     | 2023-02-15  | Docker image GHA fails | Failure in Docker image generation via GitHub Actions | Internal ticket | Execution Core | Deployment issues | DONE | 
| Security       | High     | 2023-03-05  | Clearing house authentication | Adding authentication header for clearing house | Internal ticket | Data App | Security enhancement | DONE |
| Functional     | Medium   | 2023-06-01  | Error in log for self description | Erroneous log entries when requesting self description | https://github.com/Engineering-Research-and-Development/true-connector-execution_core_container/issues/192| Execution Core | Log clarity | DONE
| Documentation | High | 2023-09-18 | Error in the curl comman in the "Testing DataApp Provider endoint" section of the readme | The curl call mentioned in the documentation, triggers a parsing error | https://github.com/Engineering-Research-and-Development/true-connector-basic_data_basapp/issues/107 | Data App | Users not able to explore TC | DONE |

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

## GitHub issues made by end users

As TrueConnector is an open-source project, we highly encourage end users to report any bugs they encounter. Our goal is to address and resolve these issues promptly.

### 1. Initial Review
- **Acknowledge the Issue**: Quickly acknowledge the new issue, ideally within 24-48 hours.
  - Label the issue appropriately (e.g., bug, feature request, enhancement).
  - Ask for more information if the issue is unclear or incomplete.

### 2. Prioritization
- **Assess Urgency and Impact**: Determine the issue's priority based on its urgency, impact on the project, and user needs.
- **Set Milestones**: Assign the issue to a specific milestone if it aligns with project's roadmap and priorities.

### 3. Planning
- **Assign Responsibility**: Assign the issue to a team member who has the expertise and capacity to handle it.
- **Estimate Timeline**: Provide an estimated timeline for when the issue might be addressed, if possible.

### 4. Communication
- **Keep Open Communication**: Update the issue thread with progress reports, questions, or requests for feedback.

### 5. Fixing issue
- **Implement Solution**: Resolve the issue through code changes, documentation updates, or other necessary actions.
- **Code Review and Testing**: Ensure that any code changes are reviewed and tested thoroughly.
- **Close with Explanation**: Once resolved, close the issue with a comment explaining the resolution or linking to the relevant pull request.


## Management of Security Issue Implementation

For managing security issues, a comprehensive approach is adopted:

1. **Automated Security Scanning**: Continuous monitoring for vulnerabilities in dependencies using tools like GitHub Dependabot, which automatically updates vulnerable dependencies.

2. **GitHub Actions for CI**: Leveraging GitHub Actions for continuous integration to build and test every commit, ensuring detection of any new vulnerabilities introduced.

3. **Code Review and Quality Assurance**: Rigorous peer review process for all code changes, especially those addressing security issues, to prevent the introduction of new vulnerabilities.

4. **Test Coverage**: Emphasizing comprehensive test coverage, including unit, integration, and end-to-end tests, to detect vulnerabilities early in the development cycle.

5. **Documentation and Tracking**: Thorough documentation of all security fixes, detailing the vulnerability, the fix, and the impact on the system.

## Status of the issues

As mentioned earlier, GitHub, used alongside Dependabot, serves as a system for monitoring reported issues, tracking the progress of ongoing issues, and recording closed issues. 

Status of issues can be:

* Open - issues is reported by end user, team member or Dependabot
* Under investigation - checking reported issue, labeling, categorizing and assigning it
* Closed - issue is patched 

The most recent status updates for each component are available:

1. Automated security issues reported by Dependabot

| Severity  | Report Date | Issue                                              | Affected Component | Solution        | Status |
|:---------:|:-----------:|:--------------------------------------------------:|:------------------:|:---------------:|:------:|
| High      | 2022-04     | json stack overflow vulnerability                  | ECC                | Bump to v20230227 | DONE |
| Critical  | 2022-02     | Arbitrary code execution in Apache Commons Text	   | DataApp            | Bump to v1.10.0 | DONE   |
| Critical  | 2022-02     | Arbitrary code execution in Apache Commons Text    | ECC                | Bump to v1.10.0 | DONE   |
| Moderate  | 2022-04     | Chosen Ciphertext Attack in Jose4j                 | ECC                | Bump to v0.9.3  | DONE   |
| Moderate  | 2022-01     | Improper Locking in JetBrains Kotlin               | ECC                | Bump to v1.6.0  | DONE   |
| Moderate  | 2021-01     | Timing based private key exposure in Bouncy Castle | ECC                | Bump to v1.66   | DONE   |


2. Open issues - [ECC](https://github.com/Engineering-Research-and-Development/true-connector-execution_core_container/issues), [DataApp](https://github.com/Engineering-Research-and-Development/true-connector-basic_data_app/issues)
3. Changelogs (Closed implemented issues) - [ECC](https://github.com/Engineering-Research-and-Development/true-connector-execution_core_container/blob/1.14.7/CHANGELOG.md),[DataApp](https://github.com/Engineering-Research-and-Development/true-connector-basic_data_app/blob/0.3.8/CHANGELOG.md), [UCDataApp](https://github.com/Engineering-Research-and-Development/true-connector-uc_data_app_platoon/blob/1.7.8/CHANGELOG.md)

