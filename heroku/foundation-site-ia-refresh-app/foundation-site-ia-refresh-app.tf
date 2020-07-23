resource "heroku_app" "foundation-site-ia-refresh" {
  name   = "foundation-site-ia-refresh"
  region = "us"

  buildpacks = [
    "heroku/nodejs",
    "heroku/python"
  ]

  organization {
    name = var.heroku_team_name
  }

  acm = "true"

  config_vars = {
    ALLOWED_HOSTS                      = "ia-refresh.mofostaging.net,foundation-site-ia-refresh.herokuapp.com",
    ASSET_DOMAIN                       = "ia-refresh.mofostaging.net",
    AWS_S3_CUSTOM_DOMAIN               = "assets.mofostaging.net",
    AWS_LOCATION                       = "network",
    AWS_STORAGE_BUCKET_NAME            = "mofo-assets-staging",
    CLOUDINARY_CLOUD_NAME              = "mozilla-foundation-staging",
    CONTENT_TYPE_NO_SNIFF              = "True"
    CORAL_TALK_SERVER_URL              = "https://comments-mofo-org-staging.herokuapp.com/",
    CORS_REGEX_WHITELIST               = "",
    CORS_WHITELIST                     = "*",
    CRM_AWS_SQS_REGION                 = "us-east-1",
    CSP_CHILD_SRC                      = "'self' https://www.youtube.com https://www.youtube-nocookie.com",
    CSP_CONNECT_SRC                    = "*",
    CSP_DEFAULT_SRC                    = "'none'",
    CSP_FONT_SRC                       = "'self' https://fonts.gstatic.com https://fonts.googleapis.com https://code.cdn.mozilla.net https://assets.mofostaging.net/static/",
    CSP_FRAME_ANCESTORS                = "'none'",
    CSP_FRAME_SRC                      = "'self' https://www.youtube.com  https://s3.amazonaws.com/ask-mozilla/ https://auremoser.carto.com https://comments.mozillafoundation.org/ https://airtable.com https://docs.google.com/ https://platform.twitter.com https://public.zenkit.com https://calendar.google.com https://www.youtube-nocookie.com https://devopstypeform.typeform.com https://mozillafoundation.nutickets.com",
    CSP_IMG_SRC                        = "* data:",
    CSP_MEDIA_SRC                      = "'self' https://s3.amazonaws.com/mofo-assets/foundation/video/",
    CSP_SCRIPT_SRC                     = "'self' 'unsafe-inline' https://www.google-analytics.com/analytics.js http://*.shpg.org/ https://comments.mozillafoundation.org/ https://airtable.com https://platform.twitter.com https://cdn.syndication.twimg.com https://assets.mofostaging.net/static/",
    CSP_STYLE_SRC                      = "'self' 'unsafe-inline' https://code.cdn.mozilla.net https://fonts.googleapis.com  https://platform.twitter.com https://assets.mofostaging.net/static/",
    DEBUG                              = "False",
    DJANGO_LOG_LEVEL                   = "DEBUG",
    DOMAIN_REDIRECT_MIDDLEWARE_ENABLED = "True",
    ENABLE_WAGTAIL                     = "True",
    ERROR_PAGE_URL                     = "https://s3.amazonaws.com/foundation-mozilla-org-maintenance/maintenance.html",
    MAINTENANCE_PAGE_URL               = "https://s3.amazonaws.com/foundation-mozilla-org-maintenance/maintenance.html",
    NETWORK_SITE_URL                   = "https://foundation-site-ia-refresh.herokuapp.com",
    NPM_CONFIG_PRODUCTION              = "true",
    PULSE_API_DOMAIN                   = "https://api.mozillapulse.org",
    PULSE_DOMAIN                       = "https://www.mozillapulse.org",
    SENTRY_ENVIRONMENT                 = "Staging",
    SET_HSTS                           = "True",
    SOCIAL_AUTH_LOGIN_REDIRECT_URL     = "/soc/complete/google-oauth2/",
    SSL_REDIRECT                       = "True",
    STATIC_HOST                        = "https://assets.mofostaging.net",
    TARGET_DOMAINS                     = "ia-refresh.mofostaging.net",
    USE_CLOUDINARY                     = "True",
    USE_S3                             = "True",
    USE_X_FORWARDED_HOST               = "True",
    WEB_CONCURRENCY                    = "4",
    X_FRAME_OPTIONS                    = "DENY",
    XSS_PROTECTION                     = "True"
  }

  sensitive_config_vars = {
    AWS_ACCESS_KEY_ID                = var.AWS_ACCESS_KEY_ID,
    AWS_SECRET_ACCESS_KEY            = var.AWS_SECRET_ACCESS_KEY,
    CLOUDINARY_API_KEY               = var.CLOUDINARY_API_KEY,
    CLOUDINARY_API_SECRET            = var.CLOUDINARY_API_SECRET,
    CRM_AWS_SQS_ACCESS_KEY_ID        = var.CRM_AWS_SQS_ACCESS_KEY_ID,
    CRM_AWS_SQS_SECRET_ACCESS_KEY    = var.CRM_AWS_SQS_SECRET_ACCESS_KEY,
    CRM_PETITION_SQS_QUEUE_URL       = var.CRM_PETITION_SQS_QUEUE_URL,
    DJANGO_SECRET_KEY                = var.DJANGO_SECRET_KEY,
    PETITION_SQS_QUEUE_URL           = var.PETITION_SQS_QUEUE_URL,
    SENTRY_DSN                       = var.SENTRY_DSN
    SOCIAL_AUTH_GOOGLE_OAUTH2_KEY    = var.SOCIAL_AUTH_GOOGLE_OAUTH2_KEY
    SOCIAL_AUTH_GOOGLE_OAUTH2_SECRET = var.SOCIAL_AUTH_GOOGLE_OAUTH2_SECRET
  }
}

resource "heroku_addon" "redis" {
  app  = heroku_app.foundation-site-ia-refresh.name
  plan = "heroku-redis:hobby-dev"
}

resource "heroku_addon" "database" {
  app  = heroku_app.foundation-site-ia-refresh.name
  plan = "heroku-postgresql:hobby-basic"
}

resource "heroku_app_feature" "dyno_metadada" {
  app  = heroku_app.foundation-site-ia-refresh.name
  name = "runtime-dyno-metadata"
}

resource "heroku_domain" "custom-domain" {
  app      = heroku_app.foundation-site-ia-refresh.name
  hostname = "ia-refresh.mofostaging.net"
}

resource "heroku_formation" "web-dyno" {
  app      = heroku_app.foundation-site-ia-refresh.name
  quantity = 1
  size     = "standard-1x"
  type     = "web"
}
