{ ... }:
{
  programs.git = {
    enable = true;
    userName = "Lemuel DLS";
    userEmail = "26912197+lemueldls@users.noreply.github.com";
    # lfs.enable = true;
    extraConfig = {
      commit.gpgSign = true;
      safe.directory = "/opt/flutter";
      gpg.format = "ssh";
      merge.ff = true;
      init.defaultBranch = "main";
      core = {
        editor = "helix";
        compression = 9;
        whitespace = "error";
        preloadindex = true;
      };
      advice = {
        addEmptyPathspec = false;
        pushNonFastForward = false;
        statusHints = false;
      };
      status = {
        branch = true;
        showStash = true;
        showUntrackedFiles = "all";
      };
      diff = {
        context = 3;
        renames = "copies";
        interHunkContext = 10;
      };
      interactive = {
        singlekey = true;
      };
      push = {
        autoSetupRemote = true;
        default = "current";
        followTags = true;
      };
      pull = {
        default = "current";
        rebase = false;
      };
      rebase = {
        autoStash = true;
        missingCommitsCheck = "warn";
      };
      log = {
        abbrevCommit = true;
        graphColors = "blue,yellow,cyan,magenta,green,red";
      };
      "color \"decorate\"" = {
        HEAD = "red";
        branch = "blue";
        tag = "green";
        remoteBranch = "magenta";
      };
      "color \"branch\"" = {
        current = "magenta";
        local = "default";
        remote = "yellow";
        upstream = "green";
        plain = "blue";
      };
      # branch.sort = "-commiterdate";
      tag = {
        gpgsign = true;
        # sort = "-taggerdate";
      };
      pager = {
        branch = false;
        tag = false;
      };
    };
  };
}
