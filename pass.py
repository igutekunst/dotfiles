#!/usr/bin/env python3
from keyring import get_keyring
get_keyring()

import argparse, getpass
import string
from secrets import choice
import base64
import crypt


PASSWORD_STORAGE_NAME = 'cluster-vault-password'


def gen_password(len=20):
    characters = string.ascii_letters +  string.digits
    password = "".join(choice(characters) for x in range(len))
    return password


def main():
    keyring = get_keyring()
    parser = argparse.ArgumentParser()
    parser.add_argument('--set', action='store_true')
    parser.add_argument('--gen', action='store_true')
    parser.add_argument('--b64', action='store_true')
    parser.add_argument('--len', default=20, type=int)
    parser.add_argument('--crypt', action='store_true', help="Encrypt a password")

    salt = 'la6chuv7ep9ahphaaHaiH2ech3fi9e'


    args = parser.parse_args()

    if args.gen and args.set:
        password = gen_password(args.len)
        keyring.set_password('system', PASSWORD_STORAGE_NAME, password)
    elif args.set:
        password = getpass.getpass("Password: ")
        keyring.set_password('system', PASSWORD_STORAGE_NAME, password)
    elif args.gen:
        password = gen_password(args.len)
        if args.b64:
            print(base64.b64encode(password))
        else:
            print(password)
    elif args.crypt:
        password = getpass.getpass("Password to encrypt: ")
        print(crypt.crypt(password, salt))
    else:
        password = keyring.get_password('system', PASSWORD_STORAGE_NAME)
        print(password)



if __name__ == '__main__':
    main()
