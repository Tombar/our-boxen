# boxen root
set BOXEN_HOME /opt/boxen

# path
set PATH $BOXEN_HOME/rbenv/{shims,bin} $BOXEN_HOME/rbenv/plugins/ruby-build/bin $BOXEN_HOME/homebrew/bin $BOXEN_HOME/homebrew/sbin $BOXEN_HOME/bin $PATH

# man
set MANPATH $BOXEN_HOME/homebrew/share/man $MANPTH

# env
for f in "$BOXEN_HOME/env.d/*.sh";
	if test -f $f
		. $f
	end
end
