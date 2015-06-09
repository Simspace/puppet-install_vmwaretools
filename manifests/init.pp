class install_vmwaretools(
  $mediadir = 'puppet:///install/vmwaretools/',
) {

  if $::operatingsystem == 'windows' {

  acl { "${staging_windir}/install_vmwaretools":
    purge => false,
    permissions => [ { identity => 'Administrators', rights => ['full'] },],
  }

  file {"${staging_windir}/install_vmwaretools":
    source => $mediadir,
    recurse => true,
    source_permissions => ignore, 
  }

  package { 'VMware Tools':
    ensure => installed,
    source => "${staging_windir}\\install_vmwaretools\\setup.exe",
    require => [File["${staging_windir}/install_vmwaretools"], Acl["${staging_windir}/install_vmwaretools"] ],
    install_options => ['/S', '/v"/qn REBOOT=R"'],
  }
  }
}
