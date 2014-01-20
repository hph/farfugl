module Git
  def self.hash(file)
    `git log -n 1 -- #{file}`.split[1]
  end

  def self.stash
    `git stash -u`
  end

  def self.unstash
    `git stash pop`
  end

  def self.current_branch
    `git rev-parse --abbrev-ref HEAD`
  end

  def self.checkout(destination)
    `git checkout -f #{destination}`
  end
end
