# slurmmail
a mailler script for slurm

# Install
Add **MailProg** line to slurm.conf: 
```
MailProg=/okyanus/SLURM/slurmmail.sh
```
Put **slurmmail.sh** in to the path defined in **MailProg**. Don't forget to give +rx permision and set the owner as slurm user.

Copy **mailrc** file to slurm home directory (/var/lib/slurm) and rename to **.mailrc**

