#!/bin/bash
#Set variables inciales
username="ec2-user"
servers=("10.0.0.49" "10.0.2.186");
declare -A MSISDN_array
declare -A FECHA_array
declare -A SERVER_array


fecha=`date +%m-%d -d "yesterday"`
Command1="sudo cat /app1/jboss-5.1.0.GA/server/MSPGW_agent/log/MSPGWLog-2022-${fecha}-* | grep -i 'MSISDNRegistrationResponse.*success' | cut -d '>' -f 10 | cut -d '<' -f 1"

#Sacar MSISDN e TPID del Registro 
for s in "${servers[@]}"; do
	echo "sshing ${username}@${s} to run grep MSISDNRegistrationResponse.*success"
	for i in `ssh -i /home/ec2-user/izziapimvne-conf-kp.pem ${username}@${s} ${Command1}`; do
		Command2="sudo cat /app1/jboss-5.1.0.GA/server/MSPGW_agent/log/MSPGWLog-2022-${fecha}-* | grep -i 'MSISDNRegistrationRequest.*${i}' | sort -u | cut -d '>' -f 6 | cut -d '<' -f 1"
		Result=`ssh -i /home/ec2-user/izziapimvne-conf-kp.pem ${username}@${s} ${Command2}`
		echo $i","$Result","$fecha
		MSISDN_array[$i]="$Result"
		FECHA_array[$i]="$fecha"
		SERVER_array[$i]="$s"
	done
done

echo "Comlete Array List"

for a in "${!MSISDN_array[@]}"; do

######Se reemplazan los numeros telefonicos####################
remplazo=`cat /home/ec2-user/scripts/GetAccontInfoRequestbyMSISDN.xml | grep MSISDN | cut -d ">" -f 2 | cut -d "<" -f 1`
sed -i 's/'"$remplazo"'/'"$a"'/g' /home/ec2-user/scripts/GetAccontInfoRequestbyMSISDN.xml
######Se ejecuta el GetAccontInfoRequestbyMSISDN ####################
getAIR=`curl -s --header "Content-Type: text/xml;charset=UTF-8" --header "SOAPAction:urn:GetAccontInfoRequest" --data @GetAccontInfoRequestbyMSISDN.xml http://10.0.0.49:8880/mspgwservices/services/SubscriberManagement?wsdl | xmllint --format - | grep 'respCode\|MSISDN\|IMSI\|SIM'`
responsecodeGSDR=`echo "${getAIR}" | grep respCode | cut -d ">" -f 2 | cut -d "<" -f 1`
if [ $responsecodeGSDR = 0 ];
	then
		##### Se obtiene MSISDN e ICCID del GetAccontInfoRequest ###############
		MSISDN=`echo $getAIR | awk '{print $2}' | cut -d ">" -f 2 | cut -d "<" -f 1`
		ICCID=`echo $getAIR | awk '{print $4}' | cut -d ">" -f 2 | cut -d "<" -f 1`
		IMSI=`echo $getAIR | awk '{print $3}' | cut -d ">" -f 2 | cut -d "<" -f 1`
		echo $a",""${MSISDN_array[$a]}"","$MSISDN","$ICCID","$IMSI
elif [ $responsecodeGSDR = 88888 ];
	then
		###### Buscar en los Port-in Requests##########
		echo "Not found looking port-in"
		Command3="cat /app1/jboss-5.1.0.GA/server/MSPGW_agent/log/MSPGWLog-2022-* | grep -i 'portInAcceptRequest'| grep '${a}' | sort -u | cut -d '>' -f6 | cut -d '<' -f1"
		for s in "${servers[@]}"; do
			Portin=`ssh -i /home/ec2-user/izziapimvne-conf-kp.pem ${username}@${s} ${Command3}`
			if [ ! -z $Portin ];
				then
					NewMSISDN=`echo $Portin`
			fi
		done
		if [ ! -z $NewMSISDN ];
			then
				############### Se reemplaza GetAccountInfoRequestbyMSISDN ##############
				remplazo=`cat /home/ec2-user/scripts/GetAccontInfoRequestbyMSISDN.xml | grep MSISDN | cut -d ">" -f 2 | cut -d "<" -f 1`
				sed -i 's/'"$remplazo"'/'"$NewMSISDN"'/g' /home/ec2-user/scripts/GetAccontInfoRequestbyMSISDN.xml
				######Se ejecuta el GetAccontInfoRequestbyMSISDN ####################
				getAIR=`curl -s --header "Content-Type: text/xml;charset=UTF-8" --header "SOAPAction:urn:GetAccontInfoRequest" --data @GetAccontInfoRequestbyMSISDN.xml http://10.0.0.49:8880/mspgwservices/services/SubscriberManagement?wsdl | xmllint --format - | grep 'respCode\|MSISDN\|IMSI\|SIM'`
				responsecodeGSDR=`echo "${getAIR}" | grep respCode | cut -d ">" -f 2 | cut -d "<" -f 1`
				if [ $responsecodeGSDR = 0 ];
					then
						##### Se obtiene MSISDN e ICCID del GetAccontInfoRequest ###############
						MSISDN=`echo $getAIR | awk '{print $2}' | cut -d ">" -f 2 | cut -d "<" -f 1`
						ICCID=`echo $getAIR | awk '{print $4}' | cut -d ">" -f 2 | cut -d "<" -f 1`
						IMSI=`echo $getAIR | awk '{print $3}' | cut -d ">" -f 2 | cut -d "<" -f 1`
						echo $a",""${MSISDN_array[$a]}"","$MSISDN","$ICCID","$IMSI
					else
						echo $a",""${MSISDN_array[$a]}""NOT_FOUND"
						MSISDN="NOT_FOUND"
						ICCID="NOT_FOUND"
						IMSI="NOT_FOUND"
				fi
			else
				MSISDN="NOT_FOUND"
				ICCID="NOT_FOUND"
				IMSI="NOT_FOUND"
		fi
	else
		echo $a",""${MSISDN_array[$a]}""Not Found"
		MSISDN="NOT_FOUND"
		ICCID="NOT_FOUND"
		IMSI="NOT_FOUND"
fi

if [ $MSISDN != NOT_FOUND ];
	then
		##### Se reemplazan los numeros Telefonicos para el getSubscriberDataRequest ####
		remplazo1=`cat /home/ec2-user/scripts/getSubscriberDataRequest.xml | grep MSISDN | cut -d ">" -f 2 | cut -d "<" -f 1`
        sed -i 's/'"$remplazo1"'/'"$MSISDN"'/g' /home/ec2-user/scripts/getSubscriberDataRequest.xml
		######Se Ejecuta el getSubscriberDataRequest####################
        getSDR=`curl -s --header "Content-Type: text/xml;charset=UTF-8" --header "SOAPAction:urn:getSubscriberDataRequest" --data @getSubscriberDataRequest.xml http://10.0.0.49:8880/mspgwservices/services/SubscriberManagement?wsdl | xmllint --format - | grep 'errorCode\|errorMessage\|accountStatus\|validityDate'`
		responsecodeSDR=`echo "${getSDR}" | awk '{print $1}' | grep errorCode | cut -d '>' -f 2 | cut -d '<' -f 1`
		if [ -z $responsecodeSDR ];
			then
				accountStatus=`echo "${getSDR}" | awk '{print $1}' | cut -d ">" -f 2 | cut -d "<" -f 1 | head -1 | tail -1`
				if [ $accountStatus != TRANSIT ];
					then
						validityDate=`echo "${getSDR}" | awk '{print $1}' | cut -d ">" -f 2 | cut -d "<" -f 1 | head -2 | tail -1`
					else
					validityDate="NOT_FOUND"
				fi
				######Se reemplazan los numeros telefonicos para el getSubTPDetails####################
				remplazo2=`cat /home/ec2-user/scripts/getSubTPDetails.xml | grep MSISDN | cut -d ">" -f 2 | cut -d "<" -f 1`
				sed -i 's/'"$remplazo2"'/'"$MSISDN"'/g' /home/ec2-user/scripts/getSubTPDetails.xml
				######Se Ejecuta el getSubTPDetails####################
				getSTPD=`curl -s --header "Content-Type: text/xml;charset=UTF-8" --header "SOAPAction:urn:getSubTPDetailsRequest" --data @getSubTPDetails.xml http://10.0.0.49:8880/mspgwservices/services/SubscriberManagement?wsdl | xmllint --format - | grep 'respCode\|tariffPackName\|tariffPackID\|startDate\|endDate'`
				respCodeSTPD=`echo ${getSTPD} | awk '{print $1}' | cut -d ">" -f 2 | cut -d "<" -f 1 `
				if [ $respCodeSTPD = 0 ];
					then
					##### Se Obtiene el tariffPackName, tariffPackID,startDate y endDate del producto de la SIM ##################
					tariffPackName=`echo "${getSTPD}" | awk '{print $1}' | cut -d ">" -f 2 | cut -d "<" -f 1 | head -2 | tail -1`
					tariffPackID=`echo "${getSTPD}" | awk '{print $1}' | cut -d ">" -f 2 | cut -d "<" -f 1 | head -3 | tail -1`
					startDate=`echo "${getSTPD}" | awk '{print $1}' | cut -d ">" -f 2 | cut -d "<" -f 1 | head -4 | tail -1`
					endDate=`echo "${getSTPD}" | awk '{print $1}' | cut -d ">" -f 2 | cut -d "<" -f 1 | head -5 | tail -1`
					else
						tariffPackName="NOT_FOUND"
						tariffPackID="NOT_FOUND"
						startDate="NOT_FOUND"
						endDate="NOT_FOUND"
				fi
				######Se reemplazan los numeros telefonicos para el getSubPlanStatusRequest####################
				remplazo3=`cat /home/ec2-user/scripts/getSubPlanStatusRequest.xml | grep MSISDN | cut -d ">" -f 2 | cut -d "<" -f 1`
				sed -i 's/'"$remplazo3"'/'"$MSISDN"'/g' /home/ec2-user/scripts/getSubPlanStatusRequest.xml
				######Se Ejecuta el getSubPlanStatusRequest####################
				getSPSR=`curl -s --header "Content-Type: text/xml;charset=UTF-8" --header "SOAPAction:urn:getSubPlanStatusRequest" --data @getSubPlanStatusRequest.xml http://10.0.0.49:8880/mspgwservices/services/BalanceManagement?wsdl | xmllint --format - | grep '<respCode>\|<publicityId>\|<planName>\|<assignDate>\|<expiryDate>\|<renewalFlag>\|<renewalCount>\|<bucketName>\|<balanceType>\|<credited>\|<used>\|<reamining>'`
				respCodeSPSR=`echo $getSPSR | tr " " "\n" | grep '<respCode>' | cut -d ">" -f 2 | cut -d "<" -f 1`
				if [ $respCodeSPSR = 0 ];
					then
						SubPlanInfo=`echo $getSPSR | tr " " "\n" | grep -v '<respCode>' | cut -d '>' -f 2 | cut -d '<' -f 1 | paste -s -d ','`
					else
						SubPlanInfo="NO_PLAN_INFO"
				fi
			else
				accountStatus="NOT_ALLOCATED"
				validityDate="NOT_FOUND"
				tariffPackName="NOT_FOUND"
				tariffPackID="NOT_FOUND"
				startDate="NOT_FOUND"
				endDate="NOT_FOUND"
				SubPlanInfo="NO_PLAN_INFO"
		fi
	else
		accountStatus="NOT_ALLOCATED"
		validityDate="NOT_FOUND"
		tariffPackName="NOT_FOUND"
		tariffPackID="NOT_FOUND"
		startDate="NOT_FOUND"
		endDate="NOT_FOUND"
		SubPlanInfo="NO_PLAN_INFO"		
fi

WD_BW(){
        echo $a",""${MSISDN_array[$a]}"",""${FECHA_array[$a]}"",""${SERVER_array[$a]}"","$MSISDN","$ICCID","$IMSI","$accountStatus","$validityDate","$tariffPackName","$tariffPackID","$startDate","$endDate","$SubPlanInfo
}

WD_BW >> /home/ec2-user/SIMDATA/SIMINFO.csv


done 