# LTA Datamall app

This app provides screens and functionality for APIs that are exposed by the LTA Datamall (https://www.mytransport.sg/content/mytransport/home/dataMall.html)

## Prerequisites

- Flutter (https://flutter.dev/docs/get-started/install)

## Deployments

This project is using Fastlane (https://fastlane.tools/) as its deployment pipeline.

### Beta deployments

#### To deploy to iOS TestFlight from local:

```
cd ios
bundle exec fastlane beta
```

#### To deploy to Android beta from local:

TBD

## Production deployments

TBD

### Gitlab Runner Setup

## Download gitlab-runner from below

curl — output /usr/local/bin/gitlab-runner https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-darwin-amd64

## Enable executable permission

sudo chmod +x /usr/local/bin/gitlab-runner

## For register - Use this token 3d1s4zAnGMrc8Qyp8XFR

gitlab-runner register
Refer -
Goto https://gitlab.com/sascha.derungs/lta-datamall-flutter/-/settings/ci_cd
Expand Runner section

## Install runner

gitlab-runner install

## Start runner

gitlab-runner start

## Stop runner

gitlab-runner stop
