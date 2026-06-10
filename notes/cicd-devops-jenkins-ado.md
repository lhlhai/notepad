# 🚀 CI/CD: Jenkins, ADO & Docker

## 1. Azure DevOps (ADO) Template
```yaml
parameters:
- name: repoName
  default: ''
  type: string

stages:
- stage: Build
  variables:
   - name: configFile 
     value: "$(Build.SourcesDirectory)/abc"
   - group: GROUP_VAR

  jobs:
  - job: BuildDoxygen
    pool:
      name: '$(AgentDoxygen)'
    steps:
    - checkout: self
    - checkout: ${{ parameters.repoName }}
    - task: PowerShell@2
      inputs:
        targetType: 'inline'
        script: echo "This is script"
      displayName: "Run Script"
      condition: and(succeeded(), eq(variables['Build.Reason'], 'PullRequest'))

    - task: PowerShell@2
      inputs:
        targetType: 'inline'
        script: |
          $commitMessage = $env:BUILD_SOURCEVERSIONMESSAGE
      displayName: 'Name'
      condition: and(succeeded(), in(variables['Build.Reason'], 'IndividualCI', 'BatchedCI'))
```

## 2. Jenkins Groovy Scripts
### Run Jenkins as Root (Linux)
```bash
sudo vi /etc/default/jenkins
# Change $JENKINS_USER="root"
sudo chown -R root:root /var/lib/jenkins /var/cache/jenkins /var/log/jenkins
sudo systemctl restart jenkins

# OR revert back to jenkins user
sudo chown -R jenkins:jenkins /var/lib/jenkins /var/cache/jenkins /var/log/jenkins
```

### Jenkins API Endpoints
```text
# List jobs
jenkins_url/api/json?tree=jobs[name,color]

# List builds
jenkins_url/job/${job_name}/api/json?tree=builds[number,status,timestamp,id,result]

# Last build info
jenkins_url/job/${job_name}/lastBuild/api/json

# Build progress
jenkins_url/job/${job_name}/lastBuild/api/json?tree=result,timestamp,estimatedDuration
```

### Reset Build History
```groovy
def item = Jenkins.instance.getItemByFullName("Test")
item.builds.each() { build -> build.delete() }
item.updateNextBuildNumber(1)
```

### Reset Build History for a View
```groovy
import hudson.model.*
def viewName = "<VIEW>"
def view = Hudson.instance.getView(viewName)
for(item in view.getItems()) {
  println item.getName()
  item = Jenkins.instance.getItemByFullName(item.getName())
  item.builds.each() { build -> build.delete() }
  item.updateNextBuildNumber(1)
}
```

### Copy Jobs in a View
```groovy
import hudson.model.*
def viewName = "product-build-dev"
def search = "-dev"
def replace = "-prod"

def view = Hudson.instance.getView(viewName)
for(item in view.getItems()) {
  def newName = item.getName().replace(search, replace)
  def job = Hudson.instance.copy(item, newName)
  job.save()
}
```

### List All Items
```groovy
Jenkins.instance.getAllItems(AbstractItem.class).each {
  println it.fullName + " - " + it.class
}
```

### Fix CSS Issue in Reports
Add to Jenkins startup parameters:
`-Dhudson.model.DirectoryBrowserSupport.CSP="sandbox allow-scripts; default-src 'self'; style-src 'self' 'unsafe-inline';"`

## 3. Docker
### Run container ignoring entrypoint
```bash
docker run -it --entrypoint=/bin/bash --name <container-name> <image>
```