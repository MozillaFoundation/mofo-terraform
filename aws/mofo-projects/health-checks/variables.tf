# S3 backend variables
variable "allowed_account_ids" {
  description = "List of allowed AWS account ids where resources can be created"
  type        = list
  default     = []
}

variable "high-priority-services" {
  description = "Services in that list will page if down"
  type        = map
  default = {
    "foundation-site"    = "foundation.mozilla.org",
    "donate-mofo"        = "donate.mozilla.org",
    "donate-thunderbird" = "give.thunderbird.net"
    "network-pulse"      = "www.mozillapulse.org",
    "network-pulse-api"  = "api.mozillapulse.org"
  }
}

//variable "low-priority-services" {
//  description = "Services in that list will send an email if down"
//  type        = list
//  default     = []
//}
