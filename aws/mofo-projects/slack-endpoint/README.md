# SLACK ENDPOINT API

When a user clicks on a button provided by one of our [slack bots](https://github.com/MozillaFoundation/mofo-devops-private/blob/master/docs/slack_bots.md), slack sends a POST request and expects a 200 in return. To do this, we use an API gateway: the `slack-endpoint` route triggers a lambda that returns a 200. We monitor this lambda with a Cloudwatch alert that will send an email to `devops@mozillafoundation.org` if the lambda runs more than 200 times in 5 minutes.

## Configuration

All our bot talks to the `slack-endpoint` route.

To modify the API:
- Do your changes.
- Zip the code if you changed it.
- run terraform plan and apply (`mofo-project` AWS account).

If the API's url has changed:
- Got to: https://api.slack.com/apps
- For every app, modify the `Request URL` in the `Interactivity & Shortcuts ` section.
