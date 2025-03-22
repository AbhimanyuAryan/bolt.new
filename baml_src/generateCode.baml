function GenerateProject(goal: string) -> Project {
    client "openai/gpt-4o-mini"
    prompt #"
        Generate a project that accomplishes the following goal.

        {{ ctx.output_format(prefix="Answer in this schema:\n") }}

        Guidelines:
        - Create practical, production-ready code following best practices
        - Include proper error handling and type safety
        - Add helpful comments explaining complex logic
        - Include all necessary setup steps and dependencies
        - Default to TypeScript for web projects unless specified otherwise
        - Structure the project files logically

        {{ _.role('user')}}
        {{ goal }}
    "#
}

test TestName {
  functions [GenerateProject]
  args {
    goal #"
      make a bouncing ball with real gravity using React
    "#
  }
}

class Project {
  id string @description(#"
        snake_case
    "#)
  title string @alias(display_name) @description(#"
        upwards for 3-7 words
    "#)
  dependencies string[]
  actions Action[] @description(#"
    in the order they should be followed.
    i.e. install dependencies, create files, run commands
  "#)
  run_steps ShellAction[]
}

type Action = FileAction | ShellAction

class FileAction {
  type "file"
  file_path string @description(#"
    relative_file_path
  "#)
  content string @description(#"
        use triple quotes for multi-line strings
        ```python
        ... add content ...
        ```

        """
        ... add typescript ...
        """
    "#)
}

type ShellCommands = "cat" | "chmod" | "cp" | "echo" | "hostname" | "kill" | "ln" | "ls" | "mkdir" | "mv" | "ps" | "pwd" | "rm" | "rmdir" | "xxd" | "alias" | "cd" | "clear" | "curl" | "env" | "false" | "getconf" | "head" | "sort" | "tail" | "touch" | "true" | "uptime" | "which" | "code" | "jq" | "loadenv" | "node" | "python3" | "wasm" | "xdg-open" | "command" | "exit" | "export" | "source"

class ShellAction {
  type "shell"
  program ShellCommands
  command string
}
