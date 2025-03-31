#!/usr/bin/env nu

let git_repos = [
    { name: "dotfiles", path: "~/Github/dotfiles" },
    { name: "notes", path: "~/Notes" },
    { name: "pass", path: "~/.password-store" },
]

let git_repos_status = (
    $git_repos | each {|repo|
        cd ($repo.path | path expand)
        let status_output = (git status --short | complete | get stdout)
        let repo_status = if ($status_output | is-empty) { "Clean" } else { "Changes" }
        let full_status = (git status | complete | get stdout)

        let parsed_git_status = (
            $status_output | lines | each {|line|
                let paths = ($line | str trim | str replace "  " " " | str replace "-> " "" | split row " " | reject 0)
                let git_status_paths = (
                    if (($paths | length) == 1) {
                        { file: $paths.0, orig_file: "" }
                    } else if (($paths | length) == 2) {
                        { file: $paths.1, orig_file: $paths.0 }
                    } else {
                        { file: "", orig_file: "" }
                    }
                )

                let xy_table = ($line | split column "" W X Y | reject W)
                let x = ($xy_table | get 0.X)
                let y = ($xy_table | get 0.Y)
                let xy = $x + $y
                let git_status_XY_meaning = (
                    match [$x, $y] {
                        [" ", $y] if ($y in "AMD")  => { "Not updated" }
                        ["M", $y] if ($y in "MTD")  => { "Updated in index" },
                        ["T", $y] if ($y in "MTD")  => { "Type changed in index" },
                        ["A", $y] if ($y in "MTD")  => { "Added to index" },
                        ["D", " "]                  => { "Deleted from index" },
                        ["R", $y] if ($y in "MTD")  => { "Renamed in index" },
                        ["C", $y] if ($y in "MTD")  => { "Copied in index" },

                        [$x, " "] if ($x in "MTARC")    => { "Index and work tree matches" },
                        [$x, "M"] if ($x in "MTARC ")   => { "Work tree changed since index" },
                        [$x, "T"] if ($x in "MTARC ")   => { "Type changed in work tree since index" },
                        [$x, "D"] if ($x in "MTARC ")   => { "Deleted in work tree" },
                        [" ", "R"]                      => { "Renamed in work tree" },
                        [" ", "C"]                      => { "Copied in work tree" },

                        ["D", "D"]  => { "Unmerged, both deleted" },
                        ["A", "U"]  => { "Unmerged, added by us" },
                        ["U", "D"]  => { "Unmerged, deleted by them" },
                        ["U", "A"]  => { "Unmerged, added by them" },
                        ["D", "U"]  => { "Unmerged, deleted by us" },
                        ["A", "A"]  => { "Unmerged, both added" },
                        ["U", "U"]  => { "Unmerged, both modified" },

                        ["?", "?"]  => { "Untracked" },
                        ["!", "!"]  => { "Ignored" },

                        _ => { "Unknown" }
                    }
                )
                { status_code: $xy, meaning: $git_status_XY_meaning } | merge $git_status_paths
            }
        )

        if ($repo_status == "Clean") {
            print $"(ansi green)\n($repo.name) - ($repo_status): Pulling latest changes...(ansi reset)"
            try {
                git pull | complete
                {
                    name: $'(ansi attr_underline)($repo.name)(ansi reset)',
                    git_commands: $"(ansi attr_bold)Attempted Pull\n(ansi green)git pull(ansi reset)",
                    status: $'(ansi green)($repo_status)(ansi reset)'
                }
            } catch {
                {
                    name: $'(ansi attr_underline)($repo.name)(ansi reset)',
                    git_commands: $"(ansi attr_bold)Failed Pull?\n(ansi red)git pull(ansi reset)",
                    status: $'(ansi red)($full_status)(ansi reset)'
                }
            }
        } else {
            print $"(ansi yellow)\nStatus details for ($repo.name):(ansi reset)"
            print ($parsed_git_status | table)

            # TODO: If Changes are detected, should be prompted to: git add, commit, and push changes.
            let commit_input = (input -n 1 -s $"(ansi yellow)\nChanges detected in ($repo.name).\nDo you want to commit and push changes? (ansi green)Y(ansi yellow)/(ansi red)n(ansi yellow): (ansi reset)" | str downcase)
            if (($commit_input | is-empty) or ($commit_input == "y")) {
                try {
                    print $"(ansi yellow)\nStaging all changes...(ansi reset)"
                    git add . | complete

                    print $"(ansi yellow)\nCommitting all changes...(ansi reset)"
                    git commit -av

                    print $"(ansi yellow)Pushing changes...(ansi reset)"
                    git push | complete

                    {
                        name: $'(ansi attr_underline)($repo.name)(ansi reset)',
                        git_commands: $"(ansi attr_bold)Commited and pushed(ansi green)\ngit add .\ngit commit -av\ngit push(ansi reset)",
                        status: $'(ansi green)($full_status)(ansi reset)'
                    }
                } catch {
                    {
                        name: $'(ansi attr_underline)($repo.name)(ansi reset)',
                        git_commands: $'(ansi attr_bold)Commit/Push Failed(ansi reset)',
                        status: $'(ansi red)($full_status)(ansi reset)'
                    }
                }
            } else {
                {
                    # manual skipped
                    name: $'(ansi attr_underline)($repo.name)(ansi reset)',
                    git_commands: $'(ansi attr_bold)Skipped(ansi reset)',
                    status: $'(ansi yellow)($full_status)(ansi reset)'
                }
            }
        }
    }
)

print "\nGit Repository Statuses:"
print ($git_repos_status | table -t thin)
