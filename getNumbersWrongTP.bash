for MSISDN in `cat /home/ec2-user/SIMDATA/SIMINFO.csv | cut -d "," -f 1`;
do
	TPborn=`cat /home/ec2-user/SIMDATA/SIMINFO.csv | grep $MSISDN | cut -d "," -f 2`
	TPnow=`cat /home/ec2-user/SIMDATA/SIMINFO.csv | grep $MSISDN | cut -d "," -f 11`

	PlanName=`cat /home/ec2-user/SIMDATA/SIMINFO.csv | grep $MSISDN | cut -d "," -f 15`
	SDay=`cat /home/ec2-user/SIMDATA/SIMINFO.csv | grep $MSISDN | cut -d "," -f 16 | cut -d "-" -f 1`
	SMonth=`cat /home/ec2-user/SIMDATA/SIMINFO.csv | grep $MSISDN | cut -d "," -f 16 | cut -d "-" -f 2`
	#SYear=`cat /home/ec2-user/SIMDATA/SIMINFO.csv | grep $MSISDN | cut -d "," -f 16 | cut -d "-" -f 3`

	EDay=`cat /home/ec2-user/SIMDATA/SIMINFO.csv | grep $MSISDN | cut -d "," -f 17 | cut -d "-" -f 1`
	EMonth=`cat /home/ec2-user/SIMDATA/SIMINFO.csv | grep $MSISDN | cut -d "," -f 17 | cut -d "-" -f 2`
	#EYear=`cat /home/ec2-user/SIMDATA/SIMINFO.csv | grep $MSISDN | cut -d "," -f 17 | cut -d "-" -f 3`
					
	echo " "
	#echo $TPborn
	#echo $TPnow

	if [[ "$TPnow" == "NOT_FOUND" ]] || [[ -z $TPborn ]] || ;
	then
		echo "TP: NOT_FOUND"
	else

        if [ "$TPborn" -ne "$TPnow" ];
        then
                echo "TP actual no es el mismo con el que nació - FAILED"
				echo "MSISDN:" $MSISDN
				echo "TP inicial:" $TPborn
				echo "TP actual:" $TPnow
				echo "Se procede a revisar la fecha de renovación del TP"
				
#-----------------------------------------

				#for MSISDN in `cat /home/ec2-user/SIMDATA/SIMINFO.csv | cut -d "," -f 1`; do
					
					#echo "Sday" $SDay, "SMonth" $SMonth, "EDay" $EDay, "EMonth" $EMonth
					
					declare -A meses_array
					meses=('Jan' 'Feb' 'Mar' 'Apr' 'May' 'Jun' 'Jul' 'Aug' 'Sep' 'Oct' 'Nov' 'Dec' )
					
					SSMonth=$((${meses_array[$SMonth]}))	#Convierte el mes de inicio en numero
					EEMonth=$((${meses_array[$EMonth]}))	#Convierte el mes de finalización en numero
					
				#--------------Agrega metodo de busqueda por numeros a la lista de meses
					
					i=0
					for n in "${meses[@]}"; do
						i=$(($i + 1)) 
						#echo "num" $i
						meses_array[$n]="$i"
						#echo "meses_array" ${meses_array[$n]}
					done	 
					
				#--------------Convierte los dias en base 10
					 
					SSDay=$((10#$SDay - 1))
					EEDay=$((10#$EDay - 0))
					#echo "SSDay" $SSDay, "EEDay" $EEDay

				#--------------revision de caso donde el dia de inicio es 1 - el mismo debe igualarse al ultimo dia del mes en curso
					
					if [ $SSDay -eq 0 ];
					then
						if [ ${meses_array[$SMonth]} -eq 2 ];
						then
							SSDay=28
							echo "----SSDay" $SSDay, "SSMonth" $SSMonth, "EEDay" $EEDay, "EEMonth" $EEMonth
						else
							if [ ${meses_array[$SMonth]} -eq 4 -o 6 -o 9 -o 11 ];
							then
								SSDay=30
								echo "----SSDay" $SSDay, "SSMonth" $SSMonth, "EEDay" $EEDay, "EEMonth" $EEMonth
							else 
								if [ ${meses_array[$SMonth]} -eq 1 -o 3 -o 5 -o 7 -o 8 -o 10 -o 12 ];
								then
									SSDay=31
									echo "----SSDay" $SSDay, "SSMonth" $SSMonth, "EEDay" $EEDay, "EEMonth" $EEMonth
								fi
							fi		
						fi
					fi
					
				#------------compara el End Day con el Start Day 	
					
					if [[ $EEDay -eq $SSDay && $EEMonth -eq $SSMonth ]];
					then
						echo "Fecha de renovación SUCCESS:"
						echo "Nombre del Plan:" $PlanName
						echo "Fecha de contratación:" $SDay/$SMonth
						echo "Fecha de renovación:" $EDay/$EMonth
						
					else
					
						 if [[ $EEDay -eq $SSDay && $EEMonth -ne $SSMonth ]];
						 then
							#echo "Start Day SUCCESS"
							#echo "meses_array" ${meses_array[$SMonth]}
							
							SSMonth=$((${meses_array[$SMonth]} + 1))
							
							#echo "SSMonth" $SSMonth
							#echo "EEMonth" $EEMonth
							
							echo "Fecha de renovación SUCCESS:"
							echo "MSISDN:" $MSISDN
							echo "Nombre del Plan:" $PlanName
							echo "Fecha de contratación:" $SDay/$SMonth
							echo "Fecha de renovación:" $EDay/$EMonth
						
						 else
							echo "Fecha de renovación FAILED"
							echo "MSISDN:" $MSISDN
							echo "Nombre del Plan:" $PlanName
							echo "Fecha de contratación:" $SDay/$SMonth
							echo "Fecha de renovación:" $EDay/$EMonth
							
							#echo "SSMonth" $SSMonth
							#echo "EEMonth" $EEMonth

						fi
					fi
				#done 
				
#-------------------------				
				
        else
                if [ "$TPborn" -eq "$TPnow" ];
                then
                        echo "TP actual es el mismo con el que nació - SUCCESS"
						echo "MSISDN:" $MSISDN
						echo "TP inicial:" $TPborn
						echo "TP actual:" $TPnow
                fi
        fi
		
		
	fi 
done 