#!/bin/bash
# $2 == Job Info
# $3 == Email Addres == $last

# Maximum Email count for an email address (per day ?)
MAX_MAIL=8

# Directory for storing email addresses
MAIL_COUNTER_DIR=/okyanus/SLURM/slurmmail-counter

# Log File for slurmmail.sh
SM_LOG_FILE=/okyanus/SLURM/slurmmail-log.txt

echo  "`date` SLURM $*" >>$SM_LOG_FILE

for last; do true; done

MYADRESS="$last"
WITHOUTDOMAIN="${MYADRESS//@*}"
if [ "$WITHOUTDOMAIN" == "root" ]
then
	/usr/bin/mail  -s "UHeM Sariyer root $2" "$last"
else
	if [ "$WITHOUTDOMAIN" != "$MYADRESS" ] 
	then
	        if [ ! -f "$MAIL_COUNTER_DIR/${ADRE}.txt" ]
                then
                        SENDED=0
                else
                        SENDED="`cat $MAIL_COUNTER_DIR/${ADRE}.txt`"
                fi
                ((SENDED++))
                echo "$SENDED" >"$MAIL_COUNTER_DIR/${ADRE}.txt"
                if  [ "$SENDED" -lt "$MAX_MAIL" ]
                then
			MYJOBINFO="$2"
			FRONTPART="${MYJOBINFO/Slurm Job_id=/}"
			MYJOBID="${FRONTPART// *}"
			echo "UHeM Sariyer Cluster $2" >/tmp/Job-$MYJOBID.mail.txt 
			echo "=============================================================" >>/tmp/Job-$MYJOBID.mail.txt 
			scontrol write batch_script $MYJOBID - >>/tmp/Job-$MYJOBID.mail.txt 
			LC_CTYPE=en_US.UTF-8 MAILRC=/var/lib/slurm/.mailrc /usr/bin/mail -q /tmp/Job-$MYJOBID.mail.txt -s "UHeM Sariyer Cluster $2" "$last"
			\rm  /tmp/Job-$MYJOBID.mail.txt
			exit
		else
			echo  "`date` MAXMAIL=$SENDED $*" >>$SM_LOG_FILE
		fi
	fi
fi
