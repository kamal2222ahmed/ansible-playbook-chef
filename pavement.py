from paver.tasks import task, no_help
from subprocess import call
import pytest


def run_playbook(playbook, args=[]):
    command = 'ansible-playbook {0} {1}'.format(playbook, args)
    print(command)
    call(command.split())


@task
@no_help
def test_bootstrap(options):
    """Bootstrap playbook tests"""
    args = 'test/test_playbooks.py::test_bootstrap -s'.split()
    pytest.main(args)


@task
def chef_zero_alpha(options):
    """Run chef zero playbook"""
    run_playbook('chef_zero-playbook.yml', '-i inventory/alpha')


@task
def chef_client_alpha(options):
    """Run chef zero playbook"""
    run_playbook('chef_client-playbook.yml', '-i inventory/alpha')


@task
@no_help
def test_chef_zero():
    """Test chef playbook"""
    args = 'test/test_playbooks.py::test_chef_zero_playbook -s'.split()
    pytest.main(args)


@task
@no_help
def lint():
    """Run ansible-lint on all playbooks"""
    args = 'test/test_playbooks.py::test_lint'.split()
    pytest.main(args)


@task
def test():
    """Run molecule and lint tests on all playbooks"""
    test_chef_zero()
