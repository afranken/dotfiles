#local scripts / config
This folder contains scripts and configuration used by other files in this repositopry.

These files contain personal / machine specific information and should be overwritten locally.

If the name pattern matches `.*-local`, files will be sourced in `../bash/.profile` before sourcing other files. 
(in order to be able to use environment variables in other files)