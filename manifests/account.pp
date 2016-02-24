define proftpd::account(
  $username = $title,
  $password,
  $uid,
  $gid,
  $home,
  $shell = '/bin/false',
  # Account file
  $file,
) {

  concat::fragment { "$file - $username":
    target  => $file,
    content => "${username}:${password}:${uid}:${gid}:${username}:${home}:${shell}\n",
  }

}
