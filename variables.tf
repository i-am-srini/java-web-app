variable "assessment_duration" {
  type        = string
  description = "The duration of the Inspector assessment run"
  default     = "900" # 1 hour
}

variable "enable_scheduled_event" {
  type        = bool
  description = "Enable Cloudwatch Events to schedule an assessment"
  default     = true
}
variable "name_prefix" {
  type        = string
  description = "Prefix for resource names that terraform will create"
  default = "jenkins"
}
variable "ruleset_cis" {
  type        = bool
  description = "Enable CIS Operating System Security Configuration Benchmarks Ruleset"
  default     = true
}
variable "ruleset_cve" {
  type        = bool
  description = "Enable Common Vulnerabilities and Exposures Ruleset"
  default     = true
}
variable "ruleset_network_reachability" {
  type        = bool
  description = "Enable AWS Network Reachability Ruleset"
  default     = true
}
variable "ruleset_security_best_practices" {
  type        = bool
  description = "Enable AWS Security Best Practices Ruleset"
  default     = true
}
variable "schedule_expression" {
  type        = string
  description = "AWS Schedule Expression: https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/ScheduledEvents.html"
  default     = "rate(1 minute)"
}
