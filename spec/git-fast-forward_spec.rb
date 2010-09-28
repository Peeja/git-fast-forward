require 'spec'

ENV['PATH'] = "#{File.dirname(__FILE__) + '/../bin'}:#{ENV['PATH']}"

describe "git fast-forward" do
  before do
    system <<-SH
      rm -rf test-repo
      mkdir test-repo
      cd test-repo
      git init
    SH
  end
  
  after do
    system <<-SH
      rm -rf test-repo
    SH
  end
  
  def run(commands)
    commands.split("\n").each do |command|
      command = command.strip
      next if command.empty?
      puts
      puts ">> #{command}"
      system "cd test-repo && #{command}"
    end
  end

  def commit_named(commit_name)
    `cd test-repo && git rev-parse --revs-only #{commit_name}`
  end
  
  context "the given commit is a descendent of the current branch" do
    before do
      run <<-SH
        touch initial-file
        git add initial-file
        git commit -m "Initial commit."
        git branch parent-branch
        git checkout -b descendent-branch
        touch new-file
        git add new-file
        git commit -m "Adding new-file."
      SH
    end

    it "sets the current branch to the descendent commit" do
      descendent_commit = commit_named("descendent-branch")

      run <<-SH
        git checkout parent-branch
        git fast-forward descendent-branch
      SH

      commit_named("parent-branch").should == descendent_commit
    end
  end

  context "the given commit is not a descendent of the current branch" do
    before do
      run <<-SH
        touch initial-file
        git add initial-file
        git commit -m "Initial commit."
        git checkout -b first-branch

        git branch other-branch
        touch second-file
        git add second-file
        git commit -m "Second commit."
        
        git checkout other-branch
        touch new-file
        git add new-file
        git commit -m "Adding new-file."
      SH
    end

    it "exists with a status of 1 and leaves the branch where it is" do
      first_branch_before_ff = commit_named("first-branch")

      run <<-SH
        git checkout first-branch
        git fast-forward other-branch
      SH

      $?.exitstatus.should == 1
      commit_named("first-branch").should == first_branch_before_ff
    end
  end
end
