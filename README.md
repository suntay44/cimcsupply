# Rootly Project

Welcome to the Rootly project! This guide will help you set up and run the project on your local machine.

# Directory
[Installation](https://github.com/suntay44/rootly/edit/main/README.md#installation)

[Slash Commands](https://github.com/suntay44/rootly/edit/main/README.md#slack-app-in-use-slash-commands)
## Installation

1. **Clone the repository from GitHub:**
```shell
  git clone https://github.com/suntay44/rootly.git
  cd rootly
```
2. **Install Ruby dependencies using Bundler:**
 ```shell 
  bundle install
```
3. **Start your Rails server:**
```shell 
  rails server
```

## Slack App In-Use Slash Commands

1. **Declare Incident*
```shell
  /declare [title] [description-optional] [severity-optional]

  example: /declare UserLoggedIn There is an authentication error. sev3
```

2. **Resolving Incident*
```shell
  /resolve

  example: /resolve
```
3. **Opening Closed Incident*
```shell
  /open_ticket [title] [description-optional] [severity-optional]

  example: /open_ticket C05NCHM1FAR
```

4. **Listing Recent Incident*
```shell
  /latest_incidents

  example: /latest_incidents
```