#!/bin/sh

#define parameters which are passed in.
NAME=$1

#define the template.
cat  << EOF
((filename . "./$NAME")
 (licensetext . "")
 (texwidth . 0.9)
)
EOF
