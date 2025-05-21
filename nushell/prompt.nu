def create_left_prompt [] {
    # Get current directory, replace home with ~
    let dir = (($env.PWD | str replace $env.HOME "~") | path basename)
    
    # Get username and hostname
    let username = $env.USER
    let hostname = "arch" # You can replace this with $env.HOSTNAME if available
    
    # Create bash-like prompt
    $"\n[($username)@($hostname) ($dir)]$ "
}

# Apply the prompt config
$env.PROMPT_COMMAND = { create_left_prompt }
$env.PROMPT_INDICATOR = ""
