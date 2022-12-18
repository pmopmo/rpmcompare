# rpmcompare


Reason this tool exists is to list files that needs managing in a previous non configuration managed environment 

Print all file in the filesystem that differs from what the rpm deliveres

This tool extracts all files from a downloaded rpm using rpm2cpio and compares (using cmp) them to what is in the filesystem and prints all files that differs  from the default install.

