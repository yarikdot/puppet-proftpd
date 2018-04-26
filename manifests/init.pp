# == Class proftpd
#
class proftpd (
  # module parameters
  String  $config_template    = $::proftpd::params::config_template,
  Boolean $default_config     = $::proftpd::params::default_config,
  Boolean $manage_config_file = $::proftpd::params::manage_config_file,
  String  $package_ensure     = $::proftpd::params::package_ensure,
  Boolean $package_manage     = $::proftpd::params::package_manage,
  Boolean $service_manage     = $::proftpd::params::service_manage,
  Boolean $service_enable     = $::proftpd::params::service_enable,
  String  $service_ensure     = $::proftpd::params::service_ensure,
  # os-specific parameters
  Optional[String] $prefix             = $::proftpd::params::prefix,
  String $prefix_bin         = $::proftpd::params::prefix_bin,
  String $config             = $::proftpd::params::config,
  String $base_dir           = $::proftpd::params::base_dir,
  String $log_dir            = $::proftpd::params::log_dir,
  String $run_dir            = $::proftpd::params::run_dir,
  Array[String] $packages           = $::proftpd::params::packages,
  String $service_name       = $::proftpd::params::service_name,
  String $user               = $::proftpd::params::user,
  String $group              = $::proftpd::params::group,
  String $pidfile            = $::proftpd::params::pidfile,
  String $scoreboardfile     = $::proftpd::params::scoreboardfile,
  # proftpd configuration
  Hash    $anonymous_options  = $::proftpd::params::anonymous_options,
  Boolean $anonymous_enable   = $::proftpd::params::anonymous_enable,
  Hash    $default_options    = $::proftpd::params::default_options,
  Hash    $load_modules       = $::proftpd::params::load_modules,
  Hash     $options            = $::proftpd::params::options,
  Optional[Hash] $auth_users         = $::proftpd::params::auth_users,
) inherits proftpd::params {

  include stdlib

  # resource relationships
  class { '::proftpd::install': } ->
  class { '::proftpd::config': } ~>
  class { '::proftpd::service': }

  if $::proftpd::load_modules {
    create_resources(proftpd::module, $load_modules, {})
  }
}
