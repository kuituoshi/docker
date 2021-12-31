<?php 

// uncomment this 

// $connect_hosts = array(
//   '1'=>array(
//   	"verbose" => "本地数据库",
//     "host"   => "db",
//     "port"   => "3306",
//     "user"   => "root",
//     "password" => "123"
//   )
// );

for ($i=1;$i<=count($connect_hosts);$i++) {

  /* Authentication type */
  $cfg['Servers'][$i]['auth_type'] = 'config';
  /* Server parameters */
  $cfg['Servers'][$i]['host'] = $connect_hosts[$i]['host'];
  $cfg['Servers'][$i]['port'] = $connect_hosts[$i]['port'];
  $cfg['Servers'][$i]['verbose'] = $connect_hosts[$i]['verbose'];
  $cfg['Servers'][$i]['connect_type'] = 'tcp';
  $cfg['Servers'][$i]['compress'] = false;
  /* Select mysqli if your server has it */
  $cfg['Servers'][$i]['extension'] = 'mysql';
  $cfg['Servers'][$i]['AllowNoPassword'] = false;
  $cfg['Servers'][$i]['user'] = $connect_hosts[$i]['user'];
  $cfg['Servers'][$i]['password'] = $connect_hosts[$i]['password'];

}

?>
