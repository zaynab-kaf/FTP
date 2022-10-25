export IFS=","

#script inspiré du job 7 de la semaine derniere, objectif similaire ;
cat /home/zaynab/Documents/FTP/JOB9/Shell_Userlist.csv | while read Id Prenom Nom Mdp Role
	do
	sudo userdel $Prenom-$Nom
	sudo groupdel $Prenom-$Nom
	sudo useradd $Prenom-$Nom
        echo "$Prenom-$Nom:$Mdp" | sudo chpasswd
        sudo usermod -u $Id "$Prenom-$Nom"
                if [ $Role = "Admin" ]
                then
                sudo usermod -aG sudo "$Prenom-$Nom"
                fi
        done

