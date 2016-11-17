from paver.tasks import task
from subprocess import call
import pytest


def run_playbook(playbook, args=[]):
    command = 'ansible-playbook {0} {1}'.format(playbook, args)
    print(command)
    call(command.split())


@task
def chef_zero(options):
    """Run chef_zero playbook"""
    run_playbook('chef_zero-playbook.yml')


@task
def test_chef_zero():
    """Test chef_zero playbook"""
    args = 'test/test_playbooks.py::test_chef_zero_playbook -s'.split()
    pytest.main(args)


@task
def lint():
    """Run ansible-lint on all playbooks"""
    args = 'test/test_playbooks.py::test_lint'.split()
    pytest.main(args)


@task
def test():
    """Run molecule and lint tests on all playbooks"""
    test_chef_zero()
