SIMINFO.csv
tpid con el que nacio, en caso de que sean diferentes, comparar la fecha de inicio con la actual
PLAN NAME,START DATE,END DATE  ---- end date debe ser un dia antes del mes siguiente
si no son iguales - imprimirlo como alerta

-----------------------------------------------------------------

TPIDcompare.sh

#MSISDN=`cat /home/ec2-user/SIMDATA/SIMINFO.csv | cut -d "," -f 1`

for MSISDN in `cat /home/ec2-user/SIMDATA/SIMINFO.csv | cut -d "," -f 1`;
do 
	TPborn=`cat /home/ec2-user/SIMDATA/SIMINFO.csv | grep $MSISDN | cut -d "," -f 2`
	TPnow=`cat /home/ec2-user/SIMDATA/SIMINFO.csv | grep $MSISDN | cut -d "," -f 11`
	
	if [ "$TPborn" -ne "$TPnow" ]; 
	then
		echo "TP actual no es el mismo con el que nació:"$MSISDN,$TPborn,$TPnow,"FAILED"
	else
		if [ "$TPborn" -eq "$TPnow" ];
		then
			echo "TP actual es el mismo con el que nació:"$MSISDN,$TPborn,$TPnow,"SUCCESS"
		fi
	fi
done

--------------------------------------------------------------------------

Cicle-renewal.sh

for MSISDN in `cat /home/ec2-user/SIMDATA/SIMINFO.csv | cut -d "," -f 1`;
do
	PlanName=`cat /home/ec2-user/SIMDATA/SIMINFO.csv | cut -d "," -f 15`
	SDay=`cat /home/ec2-user/SIMDATA/SIMINFO.csv | grep $MSISDN1 | cut -d "," -f 16 | cut -d "-" -f 1`
	SMonth=`cat /home/ec2-user/SIMDATA/SIMINFO.csv | grep $MSISDN1 | cut -d "," -f 16 | cut -d "-" -f 2`
	#SYear=`cat /home/ec2-user/SIMDATA/SIMINFO.csv | grep $MSISDN1 | cut -d "," -f 16 | cut -d "-" -f 3`
	EDay=`cat /home/ec2-user/SIMDATA/SIMINFO.csv | cut -d "," -f 17 | cut -d "-" -f 1`
	EMonth=`cat /home/ec2-user/SIMDATA/SIMINFO.csv | cut -d "," -f 17 | cut -d "-" -f 2`
	#EYear=`cat /home/ec2-user/SIMDATA/SIMINFO.csv | cut -d "," -f 17 | cut -d "-" -f 3`
	
	declare -A meses_array
    meses=('Jan' 'Feb' 'Mar' 'Apr' 'May' 'Jun' 'Jul' 'Aug' 'Sep' 'Oct' 'Nov' 'Dec' )
	
	i=0
	
	for n in "${meses[@]}"; do
	
		i=$(($i + 1)) 
		echo "num" $i
		meses_array[$n]="$i"
		echo "meses_array" ${meses_array[$n]}
	
	done
	

     #$PlanName,$SDay,$SMonth,$SYear, $EDay,$EMonth,$EYear
	 
	 
	SSDay=$(($SDay - 1))
	echo $SSDay
	echo $EDay
	
     if [ $EDay -eq $SSDay ];
     then
        echo "Start Day ok"
		echo "meses_array" $meses_array[$SMonth]
		SSMonth=$(($meses_array[$SMonth] + 1))
		echo "SSMonth" $SSMonth
	
	else
		echo "Start day FAILED"
		# if[  ];
		# then
			
		# fi
		
     fi

done


----------------------------------------------------------------------
compara-ciclos.sh

for n in `cat /home/ec2-user/scripts/tests/all_numbers.txt | cut -d "," -f 1`; do #revisa en archivo all_numbers
	numcvr=`cat /home/ec2-user/scripts/tests/ciclo_CVR.txt | grep $n | cut -d "," -f 1`
	cicvr=`cat /home/ec2-user/scripts/tests/ciclo_CVR.txt | grep $n | cut -d "," -f 2` 
	ciallnum=`cat /home/ec2-user/scripts/tests/all_numbers.txt | grep $n | cut -d "," -f 2 | cut -d "-" -f 1`
	count=`cat /home/ec2-user/scripts/tests/ciclo_CVR.txt | grep -c $n`
	
	if [ $count -gt 1 ];
	then
		echo "Duplicados", $n,$ciallnum,$count
	else
	
		if [ -z $numcvr ];
		then
			echo "MSISDN not found", $n
		else
		
			if [ $cicvr -ne $ciallnum ];
			then
				echo "Ciclos diferentes", $n,$ciallnum,$numcvr,$cicvr
			else
			
				if [ $cicvr = $ciallnum ];
				then
					echo "Correcto", $n,$ciallnum,$numcvr,$cicvr
				fi
			fi
		fi
	fi
done 