# 🌿 Git Commands Cheatsheet

## 1. Branch Management
### Delete all local branches (except main)
```bash
git branch | grep -v "main" | xargs git branch -D
```

### Pull & Track all remote branches
```bash
git branch -r | grep -v '\->' | while read remote; do git branch --track "${remote#origin/}" "$remote"; done
git fetch --all
git pull --all
```

### Create empty/orphan branch (No history)
```bash
git checkout --orphan new-branch
git reset --hard
git clean -fd
git commit --allow-empty -m "Initial empty commit"
git push origin new-branch
```

## 2. Commits & Reset
### Undo last commit but keep changes, move to new branch
```bash
git reset HEAD~1
git checkout -b newbranch
git add -A
git commit -m "Committed on new branch"
```

### Move commits to another branch
```bash
git log # Copy commit ID
git reset --hard HEAD~1 # Reset current branch
git checkout -b newbranch
git reset --hard <commit_id>
```

### Squash last N commits into 1
```bash
git rebase -i HEAD~3
# Change 'pick' to 'squash' for the commits you want to merge
# Fix editor: git config --global core.editor "code --wait"
```

### Get a specific file from another branch
```bash
git checkout <branch_name> -- <file_path>
```

## 3. Diff & Utils
### List changed files between current branch and main
```bash
current_branch_last_commit=$(git log -n 1 HEAD --format=%H)
main_branch_last_commit=$(git log -n 1 main --format=%H)
git diff $main_branch_last_commit $current_branch_last_commit --name-only | sed 's/^/> /' > diff.txt
```

### Count commits per author
```bash
git rev-list --all --pretty=format:"%an" | grep -v "^commit" | sort | uniq -c | sort -nr
```

### Ignore files without `.gitignore`
```bash
# Add to .git/info/exclude
```

### Fix "Filename too long" error
```bash
git config --global core.longpaths true
```

### Zip only untracked files
```bash
git status --untracked-files
git ls-files --others --exclude-standard
zip -r untracked_files.zip $(git ls-files --others --exclude-standard)
git ls-files --others --exclude-standard | xargs rm -rf
```