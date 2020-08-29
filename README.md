# slurmmail
a mailler script for slurm

# Install
Add **MailProg** line to slurm.conf: 
```
MailProg=/okyanus/SLURM/slurmmail.sh
```
Put **slurmmail.sh** in to the path defined in **MailProg**. Don't forget to give +rx permision and set the owner as slurm user. Also set **MAX_MAIL, MAIL_COUNTER_DIR** and **SM_LOG_FILE** variables in the **slurmmail.sh** file.

To reseting the numbers of the email sended, add a rm command for **MAIL_COUNTER_DIR** to **/etc/crontab** file:
```
0 0 * * 0 root \rm /okyanus/SLURM/slurmmail-counter/*.txt
```

Copy **mailrc** file to slurm home directory (/var/lib/slurm) and rename to **.mailrc** and ofcourse, change .mailrc file according to your mail server.

