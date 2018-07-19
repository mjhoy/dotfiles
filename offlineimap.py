#!/usr/bin/python
import re, subprocess, os

def get_authinfo_password(machine, login, port):
    s = "machine %s login %s port %s password ([^\s]*)" % (machine, login, port)
    p = re.compile(s)
    authinfo = os.popen("gpg -q --no-tty -d ~/.authinfo.gpg").read()
    return p.search(authinfo).group(1)

# # OSX keychain; not sure if this still works.
# def get_keychain_pass(account=None, server=None):
#     params = {
#         'security': '/usr/bin/security',
#         'command': 'find-internet-password',
#         'account': account,
#         'server': server,
#         'keychain': '/Users/mjhoy/Library/Keychains/login.keychain',
#     }
#     command = "sudo -u mjhoy %(security)s -v %(command)s -g -a %(account)s -s %(server)s %(keychain)s" % params
#     output = subprocess.check_output(command, shell=True, stderr=subprocess.STDOUT)
#     outtext = [l for l in output.splitlines()
#                if l.startswith('password: ')][0]

#     return re.match(r'password: "(.*)"', outtext).group(1)
