git fast-forward
================

`git fast-forward` is a git command which fast-forwards a branch to another commit.  It works just like merge, except that it never produces a merge commit.  Thus, it only works when you're fast-forwarding to a commit that's a descendent of the current branch.

Workflow
--------

Here's how my team usually works:

    master$ git pull --rebase
    master$ git checkout -b new-feature
    new-feature$ touch lib/new_code.rb
    new-feature$ git add lib/new_code.rb
    new-feature$ git commit -m "Implement awesome new feature."
    
      [meanwhile, other people have pushed new code to master...]
    
    new-feature$ git fetch
    new-feature$ git rebase origin/master
    new-feature$ git checkout master
    master$ git merge new-feature              ### <--- The problem.
    master$ git push
    
This usually works fine, but the last part always bugs me.  We rebase to keep a linear history---that's how we like it, as much as possible.  But we use the merge command, which, if things aren't rebased quite right, will make a merge commit, which is exactly what we don't want.  Usually, we won't notice it until it's pushed.  Doesn't happen a lot, but enough to write a better tool.


Usage
-----

It's pretty straightforward:

    $ gem install git-fast-forward  # or whatever
    $ git fast-forward <commit>

where `<commit>` is probably a topic branch you've just rebased.  If the commit isn't a descendent of your current commit (and therefore not eligible for fast-forwarding), you'll get a nice error message and that's that.  Otherwise, it'll fast forward just like `merge`.  In fact, it even *calls* `merge`.  So you'll get all that nice output.


Bugs, Requests, and Contributions
---------------------------------

This thing's pretty darn simple.  If you'd like it to do something it doesn't, feel free to [add an issue](http://github.com/Peeja/git-fast-forward/issues).  Same goes for bugs.  Patches and pull requests are certainly welcome.
