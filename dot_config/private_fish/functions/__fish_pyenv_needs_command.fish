function __fish_pyenv_needs_command
  set cmd (commandline -opc)
  if [ (count $cmd) -eq 1 -a $cmd[1] = 'pyenv' ]
    return 0
  end
  return 1
end
