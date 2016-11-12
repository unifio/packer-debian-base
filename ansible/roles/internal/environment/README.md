### Environment Ansible role

This role configures a one-shot service for setting environment variables used by other services. The service executes a Python script, which reads in configuration settings from a pre-configured S3 object, as well as environment variables found in EC2 user data. The environment variables are saved to /etc/default/environment. Configuration variables include:

- env_role: Role used to look up properties in the configuration file stored in S3

Sample statement to use the role:

`{ role: environment, env_role: "jenkins_master"}`
