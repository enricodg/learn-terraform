output "database_password" {
  value = module.my_db_1.database_password
  sensitive = true
}

output "webserver_ip" {
  value = module.my_app_1.webserver_ip
}
