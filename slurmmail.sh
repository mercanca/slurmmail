#!/bin/bash
# $2 == Job Info
# $3 == Email Addres == $last

echo  "`date` SLURM $*" >>/okyanus/SLURM/slurmmail-log.txt

for last; do true; done

MYADRESS="$last"
WITHOUTDOMAIN="${MYADRESS//@*}"
if [ "$WITHOUTDOMAIN" == "root" ]
then
	/usr/bin/mail  -s "UHeM Sariyer root $2" "$last"
else
	if [ "$WITHOUTDOMAIN" != "$MYADRESS" ] 
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
	fi
fi

