rm -rf test-repo
mkdir test-repo
cd test-repo
git init

git checkout -b topic-branch
git touch new-file
git add new-file
git commit -m "Adding new-file."

git checkout master
git fast-forward topic-branch