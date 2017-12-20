class bareos::db {
   
$script_directory = '/usr/lib/bareos/scripts'
$db_parameters = " --user='root' --password=''"
$db_type = 'mysql'

exec { "create-db":
      unless => "mysql -uroot bareos",
      command => "mysql -uroot -e \"create database bareos;\"",
    
    }
 exec { "grant--db":
      unless => "mysql -ubareos -pbareos bareos",
      command => "mysql -uroot -e \"grant all on bareos.* to 'bareos'@'localhost' identified by 'bareos';\"",
      }
 

exec { 'make_tables':
         command => "${script_directory}/make_bareos_tables ${db_type} ${db_parameters}",
             
      }
exec { 'grant_privileges':
         command  => "${script_directory}/grant_bareos_privileges ${db_type} ${db_parameters}",
         refreshonly  => true,
   }
}
