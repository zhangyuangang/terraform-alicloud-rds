locals {
  engine = "MySQL"
  engine_version = "5.7"
}
data "alicloud_db_instance_classes" "default" {
  engine = local.engine
  engine_version = local.engine_version
  category  = "Basic"
  storage_type = "cloud_ssd"
  instance_charge_type = var.instance_charge_type
  zone_id = var.zone_id
}
module "mysql" {
  source                   = "../../"
  region                   = var.region
  character_set            = var.character_set
  connection_prefix        = var.connection_prefix
  engine                   = local.engine
  engine_version           = local.engine_version
  instance_type            = var.instance_type != "" ? var.instance_type : data.alicloud_db_instance_classes.default.ids.0
  instance_storage         = var.instance_storage
  zone_id                  = var.zone_id
  instance_charge_type     = var.instance_charge_type
  name                     = var.name
  password                 = var.password
  instance_name            = var.instance_name
  vswitch_id               = var.vswitch_id
  database_list            = var.database_list
  account_name             = var.account_name
  type                     = var.type
  security_ips             = var.security_ips
  backup_period            = var.backup_period
  backup_time              = var.backup_time
  retention_period         = var.retention_period
  log_backup               = var.log_backup
  log_retention_period     = var.log_retention_period
  privilege                = var.privilege
  db_names                 = module.mysql.this_db_instance_database_name
  new_db_readonly_instance = var.new_db_readonly_instance
  new_account              = var.new_account
  new_backup_policy        = var.new_account
  new_database             = var.new_database
  new_instance             = var.new_instance
  new_privilege            = var.new_privilege
}