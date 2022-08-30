#####################################################################################
#Obtiene el estatus de la tripleta#
##################################################################################### 
#!/bin/bash
#Set variables inciales

for a in `cat /home/kali/scripts/numeros.txt`; do

	######Se reemplazan los numeros telefonicos####################
	remplazo=`cat /home/kali/scripts/GetAccontInfoRequestbyMSISDN.xml | grep MSISDN | cut -d ">" -f 2 | cut -d "<" -f 1`
	sed -i 's/'"$remplazo"'/'"$a"'/g' /home/kali/scripts/GetAccontInfoRequestbyMSISDN.xml
	
	######Se ejecuta el GetAccontInfoRequestbyMSISDN ####################
	getAIR=`curl -s --header "Content-Type: text/xml;charset=UTF-8" --header "SOAPAction:urn:GetAccontInfoRequest" --data @GetAccontInfoRequestbyMSISDN.xml https://prod.izzimvne.mx/mspgwservices/services/SubscriberManagement?wsdl | xmllint --format - | grep 'respCode\|MSISDN\|IMSI\|SIM'`
	responsecodeGSDR=`echo "${getAIR}" | grep respCode | cut -d ">" -f 2 | cut -d "<" -f 1`
	
	if [ $responsecodeGSDR = 0 ];	##### Se obtiene MSISDN e ICCID del GetAccontInfoRequest ###############
		then
		
			MSISDN=`echo $getAIR | awk '{print $2}' | cut -d ">" -f 2 | cut -d "<" -f 1`
			ICCID=`echo $getAIR | awk '{print $4}' | cut -d ">" -f 2 | cut -d "<" -f 1`
			IMSI=`echo $getAIR | awk '{print $3}' | cut -d ">" -f 2 | cut -d "<" -f 1`
			echo $MSISDN,$ICCID,$IMSI
			
		else
		if [ $responsecodeGSDR = 88888 ];		###### MSISDN NO encontrado ##########
			then
				MSISDN="NOT_FOUND"
				ICCID="NOT_FOUND"
				IMSI="NOT_FOUND"
				echo $MSISDN,$ICCID,$IMSI	
		fi
	fi
done

#####################################################################################
#Obtiene los detalles del TP asi como la fecha de contratación y renovación#
#####################################################################################

#!/bin/bash
#Set variables inciales

for a in `cat /home/kali/scripts/numeros-test.txt`; do

	######Se reemplazan los numeros telefonicos####################
	remplazo=`cat /home/kali/scripts/getSubTPDetailsRequest.xml | grep MSISDN | cut -d ">" -f 2 | cut -d "<" -f 1`
	sed -i 's/'"$remplazo"'/'"$a"'/g' /home/kali/scripts/getSubTPDetailsRequest.xml
	
	######Se ejecuta el getSubTPDetailsRequest ####################
	getAIR=`curl -s --header "Content-Type: text/xml;charset=UTF-8" --header "SOAPAction:urn:GetAccontInfoRequest" --data @getSubTPDetailsRequest.xml https://prod.izzimvne.mx/mspgwservices/services/SubscriberManagement?wsdl | xmllint --format - | grep 'respCode\|tariffPackName\|tariffPackID\|startDate\|endDate'`
	responsecodeGSDR=`echo "${getAIR}" | grep respCode | cut -d ">" -f 2 | cut -d "<" -f 1`
	
	if [ $responsecodeGSDR = 0 ];	##### Se obtiene MSISDN e ICCID del GetAccontInfoRequest ###############
		then
		
			tariffPackName=`echo $getAIR | awk '{print $2}' | cut -d ">" -f 2 | cut -d "<" -f 1`
			tariffPackID=`echo $getAIR | awk '{print $3}' | cut -d ">" -f 2 | cut -d "<" -f 1`
			startDate=`echo $getAIR | awk '{print $4}' | cut -d ">" -f 2 | cut -d "<" -f 1`
			endDate=`echo $getAIR | awk '{print $5}' | cut -d ">" -f 2 | cut -d "<" -f 1`
			echo $tariffPackName,$tariffPackID,$startDate,$endDate
			
		else
		if [ $responsecodeGSDR = 8888 ];		###### MSISDN NO encontrado ##########
			then
				tariffPackName="NOT_FOUND"
				tariffPackID="NOT_FOUND"
				startDate="NOT_FOUND"
				endDate="NOT_FOUND"
				echo $tariffPackName,$tariffPackID,$startDate,$endDate
		fi
	fi
done

#####################################################################################
#Obtiene la tripleta asi como el estatus de la linea#
#####################################################################################

#!/bin/bash
#Set variables inciales

for a in `cat /home/kali/scripts/numeros.txt`; do

	######Se reemplazan los numeros telefonicos####################
	remplazo=`cat /home/kali/scripts/GetAccontInfoRequestbyMSISDN.xml | grep MSISDN | cut -d ">" -f 2 | cut -d "<" -f 1`
	sed -i 's/'"$remplazo"'/'"$a"'/g' /home/kali/scripts/GetAccontInfoRequestbyMSISDN.xml
	
	######Se ejecuta el GetAccontInfoRequestbyMSISDN ####################
	getAIR=`curl -s --header "Content-Type: text/xml;charset=UTF-8" --header "SOAPAction:urn:GetAccontInfoRequest" --data @GetAccontInfoRequestbyMSISDN.xml https://prod.izzimvne.mx/mspgwservices/services/SubscriberManagement?wsdl | xmllint --format - | grep 'respCode\|MSISDN\|IMSI\|SIM'`
	responsecodeGSDR=`echo "${getAIR}" | grep respCode | cut -d ">" -f 2 | cut -d "<" -f 1`
	
	if [ $responsecodeGSDR = 0 ];	##### Se obtiene MSISDN e ICCID del GetAccontInfoRequest ###############
	then
		
		MSISDN=`echo $getAIR | awk '{print $2}' | cut -d ">" -f 2 | cut -d "<" -f 1`
		ICCID=`echo $getAIR | awk '{print $4}' | cut -d ">" -f 2 | cut -d "<" -f 1`
		IMSI=`echo $getAIR | awk '{print $3}' | cut -d ">" -f 2 | cut -d "<" -f 1`
		#echo $MSISDN,$ICCID,$IMSI
			
	else
		if [ $responsecodeGSDR = 88888 ];		###### MSISDN NO encontrado ##########
		then
			MSISDN="NOT_FOUND"
			ICCID="NOT_FOUND"
			IMSI="NOT_FOUND"
			#echo $MSISDN,$ICCID,$IMSI	
		fi
	fi

	if [ $MSISDN != NOT_FOUND ];
		then
		
		##### Se reemplazan los numeros Telefonicos para el getSubscriberDataRequest ####
		remplazo1=`cat /home/kali/scripts/getSubscriberDataRequest.xml | grep MSISDN | cut -d ">" -f 2 | cut -d "<" -f 1`
		sed -i 's/'"$remplazo1"'/'"$MSISDN"'/g' /home/kali/scripts/getSubscriberDataRequest.xml
		
		######Se Ejecuta el getSubscriberDataRequest####################
		getSDR=`curl -s --header "Content-Type: text/xml;charset=UTF-8" --header "SOAPAction:urn:getSubscriberDataRequest" --data @getSubscriberDataRequest.xml https://prod.izzimvne.mx/mspgwservices/services/SubscriberManagement?wsdl | xmllint --format - | grep 'errorCode\|errorMessage\|accountStatus\|validityDate\|accountType'`
		responsecodeSDR=`echo "${getSDR}" | awk '{print $1}' | grep errorCode | cut -d '>' -f 2 | cut -d '<' -f 1`
			
			if [ -z $responsecodeSDR ];
				then
				accountStatus=`echo "${getSDR}" | awk '{print $1}' | cut -d ">" -f 2 | cut -d "<" -f 1 | head -1 | tail -1`
				validityDate=`echo "${getSDR}" | awk '{print $1}' | cut -d ">" -f 2 | cut -d "<" -f 1 | head -2 | tail -1`
				accountType=`echo "${getSDR}" | awk '{print $1}' | cut -d ">" -f 2 | cut -d "<" -f 1 | head -3 | tail -1`
				echo $MSISDN,$ICCID,$IMSI,$accountStatus,$validityDate,$accountType
				#echo $accountStatus,$validityDate,$accountType
				else
				accountStatus="NOT_FOUND"
				validityDate="NOT_FOUND"
				accountType="NOT_FOUND"
				echo $MSISDN,$ICCID,$IMSI,$accountStatus,$validityDate,$accountType
				#echo $accountStatus,$validityDate,$accountType
			fi
	else
	accountStatus="NOT_FOUND"
	validityDate="NOT_FOUND"
	accountType="NOT_FOUND"
	echo $MSISDN,$ICCID,$IMSI,$accountStatus,$validityDate,$accountType
	fi
done	