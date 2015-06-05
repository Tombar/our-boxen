class people::tombar{

  osx::recovery_message {
    'If this Mac is found, please email martin.loy@batanga.com':
  }

  include osx::global::enable_keyboard_control_access
  include osx::global::expand_save_dialog
  include osx::global::disable_remote_control_ir_receiver

  include osx::global::enable_standard_function_keys

  include osx::dock::autohide
  include osx::dock::clear_dock
  include osx::dock::2d
  include osx::dock::disable_dashboard

  include osx::finder::show_hidden_files
  include osx::finder::empty_trash_securely
  include osx::finder::enable_quicklook_text_selection
  include osx::finder::show_warning_before_emptying_trash
  include osx::finder::show_warning_before_changing_an_extension
  include osx::finder::show_all_filename_extensions
  include osx::finder::no_file_extension_warnings

  boxen::osx_defaults { 'When performing a search, search the current folder by default':
    user   => $::boxen_user,
    key    => 'FXDefaultSearchScope',
    domain => 'com.apple.finder',
    value  => 'SCcf',
    type   => 'string'
  }

  include osx::no_network_dsstores
  include osx::disable_app_quarantine

  include osx::mouse::swipe_between_pages

  boxen::osx_defaults { 'Enable Yosemite Dark theme':
    user   => $::boxen_user,
    key    => 'AppleInterfaceTheme',
    domain => '/Library/Preferences/.GlobalPreferences',
    value  => 'dark';
  }

  class { 'osx::sound::interface_sound_effects':
    enable => false
  }
  
  class { 'osx::dock::icon_size':
    size => 36
  }


  # install all Applications
  $cask_apps = hiera('cask_apps', {})
  package { $cask_apps: provider => 'brewcask' }

  include iterm2::stable
  include iterm2::colors::solarized_light
  include iterm2::colors::solarized_dark
  include iterm2::colors::arthur

  class { 'vagrant':
    completion => true,
  }
  vagrant::plugin { ['cachier', 'r10k', 'hostmaster']:}

  include bash
  include bash::completion
  include ctags
  include geoip
  include tmux

  include vim
  vim::bundle { [
    'scrooloose/syntastic',
    'scrooloose/nerdtree',
    'tpope/vim-fugitive',
    'godlygeek/tabular',
    'rizzatti/dash.vim',
    'rodjek/vim-puppet',
    'evanmiller/nginx-vim-syntax',
    'derekwyatt/vim-scala'
  ]:
  }

  include fish

  git::config::global { 'user.email': value => 'martinloy.uy@gmail.com' }
  git::config::global { 'user.name': value => 'Martin Loy' }
  git::config::global { 'color.ui': value => 'auto' }
  git::config::global { 'branch.autosetuprebase': value => 'always' }

  # set a global gitignore file
  git::config::global { 'core.excludesfile ':
    value   => '~/.gitignore',
    require => File["/Users/${::luser}/.gitignore"]
  }

  package { ['pwgen', 'w3m', 'bwm-ng', 'jq', 'unrar', 'pstree', 'wget', 'watch']:
    ensure => present
  }

  # gem install libxml-ruby -- --with-xml2-lib=/opt/boxen/homebrew/opt/libxml2/lib

}
