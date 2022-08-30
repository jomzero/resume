
#!/bin/bash
#date +%m-%d -d "yesterday"
m="06"
d="02"

echo "MSISDNRegistrationRequest"

for File in `grep -i "MSISDNRegistrationRequest" /app1/jboss-5.1.0.GA/server/MSPGW_agent/log/MSPGWLog-2022-$m-$d* | sort -u | cut -d ':' -f 1`; do
	
	#echo $File


		for MSISDN in `cat $File | grep -i "MSISDNRegistrationRequest" | sort -u | cut -d '<' -f 4 | cut -d '>' -f 2`; do
			
			echo " "
			
			#echo $MSISDN
			nlinea=`cat $File | grep -n "MSISDNRegistrationRequest.*$MSISDN" | head -1 | cut -d ':' -f 1`
			#echo $nlinea
			tline=`expr $nlinea + 1`
			#echo $tline
			Fecha=`cat $File | awk "NR==$tline" | cut -d ':' -f 4 | cut -d ' ' -f 1`
			#echo $Fecha
			Hora=`cat $File | awk "NR==$tline" | cut -d ' ' -f 2 | cut -d ':' -f 1,2,3`
			#echo $Hora
			
			echo $MSISDN,$Fecha,$Hora
			
		done
done 



#####################################################################
echo " "
echo "activateSubscriberRequest"


#!/bin/bash
#date +%m-%d -d "yesterday"
#m="06"
#d="02"

for File in `grep -i "activateSubscriberRequest" /app1/jboss-5.1.0.GA/server/MSPGW_agent/log/MSPGWLog-2022-$m-$d* | sort -u | cut -d ':' -f 1`; do
	
	#echo $File


		for MSISDN in `cat $File | grep -i "activateSubscriberRequest" | sort -u | cut -d '<' -f 4 | cut -d '>' -f 2`; do
			
			echo " "
			
			#echo $MSISDN
			nlinea=`cat $File | grep -n "activateSubscriberRequest.*$MSISDN" | head -1 | cut -d ':' -f 1`
			#echo $nlinea
			tline=`expr $nlinea + 1`
			#echo $tline
			Fecha=`cat $File | awk "NR==$tline" | cut -d ':' -f 4 | cut -d ' ' -f 1`
			#echo $Fecha
			Hora=`cat $File | awk "NR==$tline" | cut -d ' ' -f 2 | cut -d ':' -f 1,2,3`
			#echo $Hora
			
			echo $MSISDN,$Fecha,$Hora
			
		done
done 


#####################################################################
echo " "
echo "changeTPRequest"

#!/bin/bash
#date +%m-%d -d "yesterday"
#m="06"
#d="02"

for File in `grep -i "changeTPRequest" /app1/jboss-5.1.0.GA/server/MSPGW_agent/log/MSPGWLog-2022-$m-$d* | sort -u | cut -d ':' -f 1`; do
	
	#echo $File


		for MSISDN in `cat $File | grep -i "changeTPRequest" | sort -u | cut -d '<' -f 4 | cut -d '>' -f 2`; do
			
			echo " "
			
			#echo $MSISDN
			nlinea=`cat $File | grep -n "changeTPRequest.*$MSISDN" | head -1 | cut -d ':' -f 1`
			#echo $nlinea
			tline=`expr $nlinea + 1`
			#echo $tline
			Fecha=`cat $File | awk "NR==$tline" | cut -d ':' -f 4 | cut -d ' ' -f 1`
			#echo $Fecha
			Hora=`cat $File | awk "NR==$tline" | cut -d ' ' -f 2 | cut -d ':' -f 1,2,3`
			#echo $Hora
			
			echo $MSISDN,$Fecha,$Hora
			
		done
done 



#####################################################################
echo " "
echo "ExchangeSimRequest"


#!/bin/bash
#date +%m-%d -d "yesterday"
#m="06"
#d="02"

for File in `grep -i "ExchangeSimRequest" /app1/jboss-5.1.0.GA/server/MSPGW_agent/log/MSPGWLog-2022-$m-$d* | sort -u | cut -d ':' -f 1`; do
	
	#echo $File


		for MSISDN in `cat $File | grep -i "ExchangeSimRequest" | sort -u | cut -d '<' -f 5 | cut -d '>' -f 2`; do
			
			#echo " "
			
			#echo $MSISDN
			nlinea=`cat $File | grep -n "ExchangeSimRequest.*$MSISDN" | head -1 | cut -d ':' -f 1`
			#echo $nlinea
			tline=`expr $nlinea + 1`
			#echo $tline
			Fecha=`cat $File | awk "NR==$tline" | cut -d ':' -f 4 | cut -d ' ' -f 1`
			#echo $Fecha
			Hora=`cat $File | awk "NR==$tline" | cut -d ' ' -f 2 | cut -d ':' -f 1,2,3`
			#echo $Hora
			
			echo $MSISDN,$Fecha,$Hora
			
		done
done 



#####################################################################
echo " "
echo "SuspendAccountRequest"


#!/bin/bash
#date +%m-%d -d "yesterday"
#m="06"
#d="13"

for File in `grep -i "SuspendAccountRequest" /app1/jboss-5.1.0.GA/server/MSPGW_agent/log/MSPGWLog-2022-$m-$d* | sort -u | cut -d ':' -f 1`; do
	
	#echo $File


		for MSISDN in `cat $File | grep -i "SuspendAccountRequest" | sort -u | cut -d '<' -f 4 | cut -d '>' -f 2`; do
			
			#echo " "
			
			#echo $MSISDN
			nlinea=`cat $File | grep -n "SuspendAccountRequest.*$MSISDN" | head -1 | cut -d ':' -f 1`
			#echo $nlinea
			tline=`expr $nlinea + 1`
			#echo $tline
			Fecha=`cat $File | awk "NR==$tline" | cut -d ':' -f 4 | cut -d ' ' -f 1`
			#echo $Fecha
			Hora=`cat $File | awk "NR==$tline" | cut -d ' ' -f 2 | cut -d ':' -f 1,2,3`
			#echo $Hora
			
			echo $MSISDN,$Fecha,$Hora
			
		done
done 



#####################################################################
echo " "
echo "stateChangeRequest"


#!/bin/bash
#date +%m-%d -d "yesterday"
#m="06"
#d="02"

for File in `grep -i "stateChangeRequest" /app1/jboss-5.1.0.GA/server/MSPGW_agent/log/MSPGWLog-2022-$m-$d* | sort -u | cut -d ':' -f 1`; do
	
	#echo $File


		for MSISDN in `cat $File | grep -i "stateChangeRequest" | sort -u | cut -d '<' -f 4 | cut -d '>' -f 2`; do
			
			#echo " "
			
			#echo $MSISDN
			nlinea=`cat $File | grep -n "stateChangeRequest.*$MSISDN" | head -1 | cut -d ':' -f 1`
			#echo $nlinea
			tline=`expr $nlinea + 1`
			#echo $tline
			Fecha=`cat $File | awk "NR==$tline" | cut -d ':' -f 4 | cut -d ' ' -f 1`
			#echo $Fecha
			Hora=`cat $File | awk "NR==$tline" | cut -d ' ' -f 2 | cut -d ':' -f 1,2,3`
			#echo $Hora
			
			echo $MSISDN,$Fecha,$Hora
			
		done
done 



#####################################################################
echo " "
echo "reActivateSubscriberRequest"


#!/bin/bash
#date +%m-%d -d "yesterday"
#m="06"
#d="02"

for File in `grep -i "reActivateSubscriberRequest" /app1/jboss-5.1.0.GA/server/MSPGW_agent/log/MSPGWLog-2022-$m-$d* | sort -u | cut -d ':' -f 1`; do
	
	#echo $File


		for MSISDN in `cat $File | grep -i "reActivateSubscriberRequest" | sort -u | cut -d '<' -f 4 | cut -d '>' -f 2`; do
			
			#echo " "
			
			#echo $MSISDN
			nlinea=`cat $File | grep -n "reActivateSubscriberRequest.*$MSISDN" | head -1 | cut -d ':' -f 1`
			#echo $nlinea
			tline=`expr $nlinea + 1`
			#echo $tline
			Fecha=`cat $File | awk "NR==$tline" | cut -d ':' -f 4 | cut -d ' ' -f 1`
			#echo $Fecha
			Hora=`cat $File | awk "NR==$tline" | cut -d ' ' -f 2 | cut -d ':' -f 1,2,3`
			#echo $Hora
			
			echo $MSISDN,$Fecha,$Hora
			
		done
done 



#####################################################################
echo " "
echo "portInAcceptRequest"


#!/bin/bash
#date +%m-%d -d "yesterday"
#m="06"
#d="02"

for File in `grep -i "portInAcceptRequest" /app1/jboss-5.1.0.GA/server/MSPGW_agent/log/MSPGWLog-2022-$m-$d* | sort -u | cut -d ':' -f 1`; do
	
	#echo $File


		for MSISDN in `cat $File | grep -i "portInAcceptRequest" | sort -u | cut -d '<' -f 4 | cut -d '>' -f 2`; do
			
			#echo " "
			
			#echo $MSISDN
			nlinea=`cat $File | grep -n "portInAcceptRequest.*$MSISDN" | head -1 | cut -d ':' -f 1`
			#echo $nlinea
			tline=`expr $nlinea + 1`
			#echo $tline
			Fecha=`cat $File | awk "NR==$tline" | cut -d ':' -f 4 | cut -d ' ' -f 1`
			#echo $Fecha
			Hora=`cat $File | awk "NR==$tline" | cut -d ' ' -f 2 | cut -d ':' -f 1,2,3`
			#echo $Hora
			
			echo $MSISDN,$Fecha,$Hora
			
		done
done 



#####################################################################
echo " "
echo "purchasePackageRequest"

#!/bin/bash
#date +%m-%d -d "yesterday"
#m="06"
#d="02"

for File in `grep -i "purchasePackageRequest" /app1/jboss-5.1.0.GA/server/MSPGW_agent/log/MSPGWLog-2022-$m-$d* | sort -u | cut -d ':' -f 1`; do
	
	#echo $File


		for MSISDN in `cat $File | grep -i "purchasePackageRequest" | sort -u | cut -d '<' -f 4 | cut -d '>' -f 2`; do
			
			#echo " "
			
			#echo $MSISDN
			nlinea=`cat $File | grep -n "purchasePackageRequest.*$MSISDN" | head -1 | cut -d ':' -f 1`
			#echo $nlinea
			tline=`expr $nlinea + 1`
			#echo $tline
			Fecha=`cat $File | awk "NR==$tline" | cut -d ':' -f 4 | cut -d ' ' -f 1`
			#echo $Fecha
			Hora=`cat $File | awk "NR==$tline" | cut -d ' ' -f 2 | cut -d ':' -f 1,2,3`
			#echo $Hora
			
			echo $MSISDN,$Fecha,$Hora
			
		done
done 



#####################################################################
echo " "
echo "CancelAccountRequest"  ##############################################################################

#!/bin/bash
#date +%m-%d -d "yesterday"
#m="06"
#d="02"

for File in `grep -i "CancelAccountRequest" /app1/jboss-5.1.0.GA/server/MSPGW_agent/log/MSPGWLog-2022-$m-$d* | sort -u | cut -d ':' -f 1`; do
	
	#echo $File


		for MSISDN in `cat $File | grep -i "CancelAccountRequest" | sort -u | cut -d '<' -f 4 | cut -d '>' -f 2`; do
			
			#echo " "
			
			#echo $MSISDN
			nlinea=`cat $File | grep -n "CancelAccountRequest.*$MSISDN" | head -1 | cut -d ':' -f 1`
			#echo $nlinea
			tline=`expr $nlinea + 1`
			#echo $tline
			Fecha=`cat $File | awk "NR==$tline" | cut -d ':' -f 4 | cut -d ' ' -f 1`
			#echo $Fecha
			Hora=`cat $File | awk "NR==$tline" | cut -d ' ' -f 2 | cut -d ':' -f 1,2,3`
			#echo $Hora
			
			echo $MSISDN,$Fecha,$Hora
			
		done
done 



#####################################################################
echo " "
echo "IMEILockRequest"

#!/bin/bash
#date +%m-%d -d "yesterday"
#m="06"
#d="02"

for File in `grep -i "IMEILockRequest" /app1/jboss-5.1.0.GA/server/MSPGW_agent/log/MSPGWLog-2022-$m-$d* | sort -u | cut -d ':' -f 1`; do
	
	#echo $File


		for IMEI in `cat $File | grep -i "IMEILockRequest" | sort -u | cut -d '<' -f 4 | cut -d '>' -f 2`; do
			
			#echo " "
			
			#echo $MSISDN
			nlinea=`cat $File | grep -n "IMEILockRequest.*$IMEI" | head -1 | cut -d ':' -f 1`
			#echo $nlinea
			tline=`expr $nlinea + 1`
			#echo $tline
			Fecha=`cat $File | awk "NR==$tline" | cut -d ':' -f 4 | cut -d ' ' -f 1`
			#echo $Fecha
			Hora=`cat $File | awk "NR==$tline" | cut -d ' ' -f 2 | cut -d ':' -f 1,2,3`
			#echo $Hora
			
			echo $IMEI,$Fecha,$Hora
			
		done
done 



#####################################################################
echo " "
echo "IMEIUnlockRequest"


#!/bin/bash
#date +%m-%d -d "yesterday"
#m="06"
#d="02"

for File in `grep -i "IMEIUnlockRequest" /app1/jboss-5.1.0.GA/server/MSPGW_agent/log/MSPGWLog-2022-$m-$d* | sort -u | cut -d ':' -f 1`; do
	
	#echo $File


		for IMEI in `cat $File | grep -i "IMEIUnlockRequest" | sort -u | cut -d '<' -f 4 | cut -d '>' -f 2`; do
			
			#echo " "
			
			#echo $IMEI
			nlinea=`cat $File | grep -n "IMEIUnlockRequest.*$IMEI" | head -1 | cut -d ':' -f 1`
			#echo $nlinea
			tline=`expr $nlinea + 1`
			#echo $tline
			Fecha=`cat $File | awk "NR==$tline" | cut -d ':' -f 4 | cut -d ' ' -f 1`
			#echo $Fecha
			Hora=`cat $File | awk "NR==$tline" | cut -d ' ' -f 2 | cut -d ':' -f 1,2,3`
			#echo $Hora
			
			echo $IMEI,$Fecha,$Hora
			
		done
done 



#####################################################################
#####################################################################
						CONSULTAS
#####################################################################
#####################################################################
GetAccontInfoRequest


#!/bin/bash
#date +%m-%d -d "yesterday"
#m="06"
#d="02"

for File in `grep -i "GetAccontInfoRequest" /app1/jboss-5.1.0.GA/server/MSPGW_agent/log/MSPGWLog-2022-$m-$d* | sort -u | cut -d ':' -f 1`; do
	
	#echo $File


		for MSISDN in `cat $File | grep -i "GetAccontInfoRequest" | sort -u | cut -d '<' -f 4 | cut -d '>' -f 2`; do
			
			#echo " "
			
			#echo $MSISDN
			nlinea=`cat $File | grep -n "GetAccontInfoRequest.*$MSISDN" | head -1 | cut -d ':' -f 1`
			#echo $nlinea
			tline=`expr $nlinea + 1`
			#echo $tline
			Fecha=`cat $File | awk "NR==$tline" | cut -d ':' -f 4 | cut -d ' ' -f 1`
			#echo $Fecha
			Hora=`cat $File | awk "NR==$tline" | cut -d ' ' -f 2 | cut -d ':' -f 1,2,3`
			#echo $Hora
			
			echo $MSISDN,$Fecha,$Hora
			
		done
done 



#####################################################################
getSubscriberDataRequest


#!/bin/bash
#date +%m-%d -d "yesterday"
#m="06"
#d="02"
echo "getSubscriberDataRequest"

for File in `grep -i "getSubscriberDataRequest" /app1/jboss-5.1.0.GA/server/MSPGW_agent/log/MSPGWLog-2022-$m-$d* | sort -u | cut -d ':' -f 1`; do
	
	#echo $File

		#incluir un if que cambie el cut en caso que sea "!--You have a CHOICE of the next 3 items at this level-->"
		
		
		for MSISDN in `cat $File | grep -i "getSubscriberDataRequest" | sort -u | cut -d '<' -f 4 | cut -d '>' -f 2`; do
			
			
			if [ "MSISDN" == "!--You have a CHOICE of the next 3 items at this level-->" ];
			then
				MSISDN="cat $File | grep -i "getSubscriberDataRequest" | sort -u | cut -d '<' -f 6 | cut -d '>' -f 2"
			
				#echo " "
				
				#echo $MSISDN
				nlinea=`cat $File | grep -n "getSubscriberDataRequest.*$MSISDN" | head -1 | cut -d ':' -f 1`
				#echo $nlinea
				tline=`expr $nlinea + 1`
				#echo $tline
				Fecha=`cat $File | awk "NR==$tline" | cut -d ':' -f 4 | cut -d ' ' -f 1`
				#echo $Fecha
				Hora=`cat $File | awk "NR==$tline" | cut -d ' ' -f 2 | cut -d ':' -f 1,2,3`
				#echo $Hora
				echo $MSISDN,$Fecha,$Hora
			else
				#echo " "
				
				#echo $MSISDN
				nlinea=`cat $File | grep -n "getSubscriberDataRequest.*$MSISDN" | head -1 | cut -d ':' -f 1`
				#echo $nlinea
				tline=`expr $nlinea + 1`
				#echo $tline
				Fecha=`cat $File | awk "NR==$tline" | cut -d ':' -f 4 | cut -d ' ' -f 1`
				#echo $Fecha
				Hora=`cat $File | awk "NR==$tline" | cut -d ' ' -f 2 | cut -d ':' -f 1,2,3`
				#echo $Hora
				echo $MSISDN,$Fecha,$Hora
			fi
			
			
		done
done 



#####################################################################
getSubPlanStatusRequest


#!/bin/bash
#date +%m-%d -d "yesterday"
# m="06"
# d="02"
echo "getSubPlanStatusRequest"

for File in `grep -i "getSubPlanStatusRequest" /app1/jboss-5.1.0.GA/server/MSPGW_agent/log/MSPGWLog-2022-$m-$d* | sort -u | cut -d ':' -f 1`; do
	
	#echo $File


		for MSISDN in `cat $File | grep -i "getSubPlanStatusRequest" | sort -u | cut -d '<' -f 5 | cut -d '>' -f 2`; do
			
			#echo " "
			
			#echo $MSISDN
			nlinea=`cat $File | grep -n "getSubPlanStatusRequest.*$MSISDN" | head -1 | cut -d ':' -f 1`
			#echo $nlinea
			tline=`expr $nlinea + 1`
			#echo $tline
			Fecha=`cat $File | awk "NR==$tline" | cut -d ':' -f 4 | cut -d ' ' -f 1`
			#echo $Fecha
			Hora=`cat $File | awk "NR==$tline" | cut -d ' ' -f 2 | cut -d ':' -f 1,2,3`
			#echo $Hora
			
			
			
			echo $MSISDN,$Fecha,$Hora
			
		done
done 


2295990980,06/02/2022,18:29:09.633
2295990982,06/02/2022,18:18:27.369
2295990980,06/02/2022,18:29:09.633
2295990982,06/02/2022,18:18:27.369
9935740984,06/02/2022,23:57:53.616
9935740984,06/02/2022,23:57:53.616
9935740984,06/02/2022,23:57:53.616