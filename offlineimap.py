import subprocess


def get_keychain_password(server, account):
    result = subprocess.run(
        ["/usr/bin/security", "find-internet-password",
         "-s", server, "-a", account, "-w"],
        capture_output=True,
        text=True,
    )
    if result.returncode != 0 or not result.stdout.strip():
        raise RuntimeError(
            "Keychain lookup failed for %s on %s" % (account, server))
    return result.stdout.rstrip("\n")
