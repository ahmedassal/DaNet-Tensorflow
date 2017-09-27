#!/usr/bin/env bash
ssh -i Alex.pem -N -f -L localhost:16007:localhost:6007 ec2-user@ec2-54-186-175-14.us-west-2.compute.amazonaws.com

