# Health-checks

Dashboard: https://console.aws.amazon.com/route53/healthchecks/home#/ (mofo-project)

## Services monitored

- foundation site
- pulse (front + api)
- donate (mofo + thunderbird)
- Internet-health-report (email only)

Send an alert after 30min of downtime.

## How to add a new service

- Paging alert: add the name and url of that service to the `high-priority-services` variable.
- email only: add the name and url of that service to the `low-priority-services` variable.

Once it's done, apply the new plan.
