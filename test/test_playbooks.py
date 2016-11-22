import pytest
import re
import shutil
import os
from os.path import curdir as cwd
from subprocess import call

test_src_dir = 'test'
test_exe_dir = '.test'
test_files = [os.path.join(test_src_dir, 'inventory'),
              os.path.join(test_src_dir, 'molecule.yml'),
              'assets',
              'docker']
molecule_playbook = 'playbook.yml'
playbook_dir = '.'
playbook_ignore = []
playbook_lint_command = 'ansible-lint'
playbook_lint_success = 0
playbook_test_command = 'molecule test'
playbook_test_success = 0


def list_playbooks(playbook_dir):
    """
    retrieve the list of playbooks in a directory
    :param playbook_dir: the path to search for playbooks
    """
    playbook_files = [f for f in os.listdir(playbook_dir)
                      if os.path.isfile(os.path.join(cwd, playbook_dir, f)) and
                      re.match(".*-playbook.yml$", f) and
                      f not in playbook_ignore]
    playbook_files = [os.path.join(playbook_dir, f) for f in playbook_files]
    return(playbook_files)


def playbook_test_dir(playbook):
    """
    return the canonical location of a playbook's test directory
    :param playbook: the target playbook
    """
    return(os.path.join(test_exe_dir, os.path.basename(playbook)))


def bootstrap_test_tree(playbook):
    """
    bootstrap the directory structure for testing a single playbook
    :param playbook: the playbook file to bootstrap for testing
    """
    test_dir = playbook_test_dir(playbook)
    shutil.rmtree(test_dir, True)
    os.makedirs(test_dir)
    for target in test_files:
        os.symlink(os.path.join('../..', target),
                   os.path.join(test_dir, os.path.basename(target)))
    os.symlink(os.path.join('../..', playbook),
               os.path.join(test_dir, molecule_playbook))
    return(test_dir)


def test_bootstrap():
    for playbook in list_playbooks(playbook_dir):
        bootstrap_test_tree(playbook)


@pytest.mark.parametrize("playbook", list_playbooks(playbook_dir))
def test_run_playbook(playbook):
    """
    run tests for a particular playbook
    :arg playbook: the target playbook
    """
    print("Bootstrapping test for playbook {0}".format(playbook))
    test_dir = bootstrap_test_tree(playbook)
    last_dir = cwd
    print("Testing playbook {0}".format(playbook))
    try:
        os.chdir(test_dir)
        assert call(playbook_test_command.split()) == 0
    finally:
        os.chdir(last_dir)


@pytest.mark.parametrize("playbook", list_playbooks(playbook_dir))
def test_lint_playbook(playbook):
    """
    perform a lint check on input playbook
    :param playbooks: the paths of the playbook file to test
    """
    print("Linting playbook {0}".format(playbook))
    assert call([playbook_lint_command, playbook]) == playbook_lint_success


def test_lint():
    """
    run lint test for all playbooks
    """
    [test_lint_playbook(x) for x in list_playbooks(playbook_dir)]


def test_chef_playbook():
    """Perform lint and run tests on chef playbook"""
    playbook = 'chef-playbook.yml'
    test_lint_playbook(playbook)
    test_run_playbook(playbook)
